import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecount/models/category_model.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/shared/home_header_search.dart' show HomeHeaderSearch;
import 'package:wecount/shared/home_list_item.dart';
import 'package:wecount/types/color.dart';
import 'package:wecount/utils/general.dart';

import '../utils/colors.dart';
import '../utils/localization.dart';

class HomeList extends StatefulWidget {
  const HomeList({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  TextEditingController textEditingController = TextEditingController();

  final _data = [];
  final _listData = [];

  // List<List<LedgerItem>> _ledgerItems = [[]];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _data.add(
        LedgerItemModel(
          price: -12000,
          category: Category(
              iconId: 8, label: t('EXERCISE'), type: CategoryType.consume),
          selectedDate: DateTime(2019, 9, 10),
        ),
      );
      _data.add(
        LedgerItemModel(
          price: 300000,
          category: Category(
              iconId: 18, label: t('WALLET_MONEY'), type: CategoryType.consume),
          selectedDate: DateTime(2019, 9, 10),
        ),
      );

      _data.add(
        LedgerItemModel(
          price: -32000,
          category: Category(
              iconId: 4, label: t('DATING'), type: CategoryType.consume),
          memo: 'who1 gave me',
          writer: UserModel(uid: 'who1@gmail.com', displayName: 'dooboolab'),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItemModel(
          price: -3100,
          category:
              Category(iconId: 0, label: t('CAFE'), type: CategoryType.consume),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItemModel(
          price: 300000,
          category: Category(
              iconId: 18, label: t('WALLET_MONEY'), type: CategoryType.consume),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItemModel(
          price: -3100,
          category:
              Category(iconId: 0, label: t('CAFE'), type: CategoryType.consume),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItemModel(
          price: -3100,
          category:
              Category(iconId: 0, label: t('CAFE'), type: CategoryType.consume),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItemModel(
          price: -3100,
          category:
              Category(iconId: 0, label: t('CAFE'), type: CategoryType.consume),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItemModel(
          price: -12000,
          category: Category(
              iconId: 12, label: t('PRESENT'), type: CategoryType.consume),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );

      _data.add(
        LedgerItemModel(
          price: -32000,
          category: Category(
              iconId: 4, label: t('DATING'), type: CategoryType.consume),
          memo: 'who1 gave me',
          writer: UserModel(uid: 'who1@gmail.com', displayName: '이범주'),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );
      _data.add(
        LedgerItemModel(
          price: -3100,
          category:
              Category(iconId: 0, label: t('CAFE'), type: CategoryType.consume),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );
      _data.add(
        LedgerItemModel(
          price: -3100,
          category:
              Category(iconId: 0, label: t('CAFE'), type: CategoryType.consume),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );
      _data.add(
        LedgerItemModel(
          price: -12000,
          category: Category(
              iconId: 12, label: t('PRESENT'), type: CategoryType.consume),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );

      _data.add(
        LedgerItemModel(
          price: -32000,
          category: Category(
              iconId: 4, label: t('DATING'), type: CategoryType.consume),
          memo: 'who1 gave me',
          writer: UserModel(uid: 'who1@gmail.com', displayName: 'dooboolab'),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );
      _data.add(
        LedgerItemModel(
          price: -3100,
          category:
              Category(iconId: 0, label: t('CAFE'), type: CategoryType.consume),
          selectedDate: DateTime(2019, 9, 4),
        ),
      );
      _data.add(
        LedgerItemModel(
          price: -2100,
          category:
              Category(iconId: 0, label: t('CAFE'), type: CategoryType.consume),
          selectedDate: DateTime(2019, 9, 4),
        ),
      );
      _data.add(
        LedgerItemModel(
          price: -12000,
          category: Category(
              iconId: 12, label: t('PRESENT'), type: CategoryType.consume),
          selectedDate: DateTime(2019, 9, 4),
        ),
      );

      // sort data
      _data.sort((a, b) {
        return a.selectedDate.compareTo(b.selectedDate);
      });

      // insert Date row as Header
      DateTime? prevDate;
      var temp = [];
      for (var i = 0; i < _data.length; i++) {
        if (prevDate != _data[i].selectedDate) {
          // 다르면 모은 데이터를 저장하고, 모음 리셋
          if (temp.isNotEmpty) {
            _listData.add({
              'date': prevDate,
              'ledgerItems': temp,
            });
          }
          prevDate = _data[i].selectedDate;
          temp = [];
        }
        temp.add(_data[i]); // 데이터 임시 모음
        // _listData.add(_data[i]);
      }
      if (temp.isNotEmpty) {
        _listData.add({
          'date': prevDate,
          'ledgerItems': temp,
        });
      }
    });
  }

  Widget _renderListHeader(DateTime date) {
    String headerString = DateFormat('yyyy-MM-dd (E)').format(date);
    return Container(
      height: 60.0,
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
          color: Theme.of(context).textTheme.headline2!.color,
        ),
      ),
    );
  }

  List<Widget> _renderList(BuildContext context) {
    return List.generate(_listData.length, (index) {
      var section = _listData[index];
      var headerDate = section['date'];
      var ledgerItems = section['ledgerItems'];
      return SliverStickyHeader(
        header: _renderListHeader(headerDate),
        sliver: SliverList(
          key: Key(index.toString()),
          delegate: SliverChildBuilderDelegate(
            (context, i) => HomeListItem(ledgerItem: ledgerItems[i]),
            childCount: ledgerItems.length,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<CurrentLedger>(context).ledger != null
        ? Provider.of<CurrentLedger>(context).ledger!.color
        : ColorType.dusk;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: HomeHeaderSearch(
          color: getColor(color),
          margin: const EdgeInsets.only(left: 20.0),
          textEditingController: textEditingController,
          actions: <Widget>[
            SizedBox(
              width: 56.0,
              child: RawMaterialButton(
                padding: const EdgeInsets.all(0.0),
                shape: const CircleBorder(),
                onPressed: () => General.instance
                    .navigateScreenNamed(context, '/ledger_item_edit'),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: _renderList(context),
          ),
        ),
      ),
    );
  }
}
