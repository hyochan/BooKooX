import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/repositories/ledger_repository.dart';
import 'package:wecount/repositories/user_repository.dart';
import 'package:wecount/services/database.dart';
import 'package:wecount/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:wecount/utils/logger.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

import 'package:wecount/widgets/home_header_search.dart' show HomeHeaderSearch;
import 'package:wecount/models/ledger_item_model.dart';
import 'package:wecount/widgets/home_list_item.dart';

import 'package:wecount/utils/localization.dart';
import 'package:intl/intl.dart';
import 'package:wecount/utils/asset.dart' as asset;

import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:provider/provider.dart';

class ListType {
  DateTime date;
  List<LedgerItemModel> ledgerItems;

  ListType({required this.date, required this.ledgerItems});
}

class HomeList extends HookWidget {
  const HomeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;
    final textEditingController = useTextEditingController();
    var listData = useState<List<ListType>>([]);
    var data = [];

    Widget renderListHeader(DateTime date) {
      String headerString = DateFormat('yyyy-MM-dd (E)').format(date);
      return Container(
        height: 60.0,
        color: Colors.white,
        padding: const EdgeInsets.only(
          top: 16.0,
          left: 10.0,
        ),
        // padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          headerString,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.bg.paper,
          ),
        ),
      );
    }

    List<Widget> renderList(BuildContext context, List<ListType> itemList) {
      return List.generate(
        itemList.length,
        (index) {
          ListType section = itemList[index];
          DateTime headerDate = section.date;
          var ledgerItems = section.ledgerItems;
          return SliverStickyHeader(
            header: renderListHeader(headerDate),
            sliver: SliverList(
              key: Key(index.toString()),
              delegate: SliverChildBuilderDelegate(
                (context, i) => HomeListItem(ledgerItem: ledgerItems[i]),
                childCount: ledgerItems.length,
              ),
            ),
          );
        },
      );
    }

    var color = Provider.of<CurrentLedger>(context).getLedger() != null
        ? Provider.of<CurrentLedger>(context).getLedger()!.color
        : ColorType.dusk;

    return Scaffold(
      backgroundColor: AppColors.bg.basic,
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        backgroundColor: asset.Colors.getColor(color),
        title: HomeHeaderSearch(
          onPressAdd: () =>
              navigation.push(context, AppRoute.ledgerItemEdit.path),
          onPressDelete: () => textEditingController.clear(),
          textEditingController: textEditingController,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: UserRepository.instance.getMe(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return const SizedBox();
            UserModel item = snapshot.data;
            return item.selectedLedger == null
                ? const SizedBox()
                : FutureBuilder(
                    future: LedgerRepository.instance.getLedgerItems(),
                    builder: (context, AsyncSnapshot ledgerSnapShot) {
                      if (!ledgerSnapShot.hasData) return const SizedBox();
                      List<LedgerItemModel> getLedgers = ledgerSnapShot.data;
                      List<ListType> itemList = [];

                      // insert Date row as Header
                      DateTime? prevDate;
                      List<LedgerItemModel> temp = [];
                      for (var i = 0; i < getLedgers.length; i++) {
                        if (prevDate != getLedgers[i].selectedDate) {
                          // 다르면 모은 데이터를 저장하고, 모음 리셋
                          if (temp.isNotEmpty) {
                            itemList.add(
                                ListType(date: prevDate!, ledgerItems: temp));
                          }
                          prevDate = getLedgers[i].selectedDate;
                          temp = [];
                        }
                        temp.add(getLedgers[i]); // 데이터 임시 모음
                      }

                      if (temp.isNotEmpty) {
                        itemList
                            .add(ListType(date: prevDate!, ledgerItems: temp));
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomScrollView(
                          slivers: renderList(context, itemList),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
