import 'package:flutter/material.dart';
import 'package:bookoo2/models/User.dart';

import 'package:bookoo2/shared/home_header_search.dart' show HomeHeaderSearch;
import 'package:bookoo2/models/Category.dart';
import 'package:bookoo2/models/LedgerItem.dart';
import 'package:bookoo2/shared/home_list_item.dart';

import 'package:bookoo2/utils/general.dart';
import 'package:bookoo2/utils/localization.dart';
import 'package:intl/intl.dart';

import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class HomeList extends StatefulWidget {
  HomeList({
    Key key,
  }) : super(key: key);

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  TextEditingController textEditingController = TextEditingController();

  var _data = [];
  var _listData = [];

  // List<List<LedgerItem>> _ledgerItems = [[]];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      var _localization = Localization.of(context);

      _data.add(
        LedgerItem(
          price: -12000,
          category: Category(
              iconId: 8,
              label: _localization.trans('EXERCISE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 10),
        ),
      );
      _data.add(
        LedgerItem(
          price: 300000,
          category: Category(
              iconId: 18,
              label: _localization.trans('WALLET_MONEY'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 10),
        ),
      );

      _data.add(
        LedgerItem(
          price: -32000,
          category: Category(
              iconId: 4,
              label: _localization.trans('DATING'),
              type: CategoryType.CONSUME),
          memo: 'who1 gave me',
          writer: User(uid: 'who1@gmail.com', displayName: 'engela lee'),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItem(
          price: 300000,
          category: Category(
              iconId: 18,
              label: _localization.trans('WALLET_MONEY'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItem(
          price: -12000,
          category: Category(
              iconId: 12,
              label: _localization.trans('PRESENT'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );

      _data.add(
        LedgerItem(
          price: -32000,
          category: Category(
              iconId: 4,
              label: _localization.trans('DATING'),
              type: CategoryType.CONSUME),
          memo: 'who1 gave me',
          writer: User(uid: 'who1@gmail.com', displayName: '이범주'),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );
      _data.add(
        LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );
      _data.add(
        LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );
      _data.add(
        LedgerItem(
          price: -12000,
          category: Category(
              iconId: 12,
              label: _localization.trans('PRESENT'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );

      _data.add(
        LedgerItem(
          price: -32000,
          category: Category(
              iconId: 4,
              label: _localization.trans('DATING'),
              type: CategoryType.CONSUME),
          memo: 'who1 gave me',
          writer: User(uid: 'who1@gmail.com', displayName: 'mizcom'),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );
      _data.add(
        LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 4),
        ),
      );
      _data.add(
        LedgerItem(
          price: -2100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 4),
        ),
      );
      _data.add(
        LedgerItem(
          price: -12000,
          category: Category(
              iconId: 12,
              label: _localization.trans('PRESENT'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 4),
        ),
      );

      // sort data
      _data.sort((a, b) {
        return a.selectedDate.compareTo(b.selectedDate);
      });

      // insert Date row as Header
      DateTime prevDate;
      var temp = [];
      for (var i = 0; i < _data.length; i++) {
        if (prevDate != _data[i].selectedDate) {
          // 다르면 모은 데이터를 저장하고, 모음 리셋
          if (temp.length > 0) {
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
      if (temp.length > 0) {
        _listData.add({
          'date': prevDate,
          'ledgerItems': temp,
        });
      }
    });
  }

  Widget _buildHeader(DateTime date) {
    String headerString = DateFormat('yyyy-MM-dd (E)').format(date);
    return Container(
      height: 60.0,
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.only(
        top: 16.0,
        left: 10.0,
      ),
      // padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        headerString,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.subtitle.color,
        ),
      ),
    );
  }

  List<Widget> _buildLists(BuildContext context) {
    return List.generate(_listData.length, (index) {
      var section = _listData[index];
      var headerDate = section['date'];
      var ledgerItems = section['ledgerItems'];
      return SliverStickyHeader(
        header: _buildHeader(headerDate),
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
    Function onAddLedgerList =
        () => General.instance.navigateScreenNamed(context, '/ledger_item_add');
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: HomeHeaderSearch(
          margin: EdgeInsets.only(left: 20.0),
          textEditingController: textEditingController,
          actions: <Widget>[
            Container(
              width: 56.0,
              child: RawMaterialButton(
                padding: EdgeInsets.all(0.0),
                shape: CircleBorder(),
                onPressed: onAddLedgerList,
                child: Icon(
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
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: _buildLists(context),
          ),
        ),
      ),
    );
  }
}
