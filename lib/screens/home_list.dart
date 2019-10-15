import 'package:flutter/material.dart';
import 'package:bookoo2/models/User.dart';

import 'package:bookoo2/shared/home_header_search.dart' show HomeHeaderSearch;
import 'package:bookoo2/models/Category.dart';
import 'package:bookoo2/models/LedgerItem.dart';
import 'package:bookoo2/shared/home_list_item.dart';

import 'package:bookoo2/utils/general.dart';
import 'package:bookoo2/utils/localization.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeList extends StatefulWidget {
  HomeList({
    Key key,
  }) : super(key: key);

  @override
  _HomeListState createState() => new _HomeListState();
}

class _HomeListState extends State<HomeList> {
  TextEditingController textEditingController = TextEditingController();
  
  var _rows = {};

  // List<List<LedgerItem>> _ledgerItems = [[]];
  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      var _localization = Localization.of(context);

      List items = [];
      items.add(new LedgerItem(
        price: -12000,
        category: Category(
            iconId: 8,
            label: _localization.trans('EXERCISE'),
            type: CategoryType.CONSUME),
        selectedDate: new DateTime(2019, 9, 10)));
      items.add(new LedgerItem(
        price: 300000,
        category: Category(
            iconId: 18,
            label: _localization.trans('WALLET_MONEY'),
            type: CategoryType.CONSUME),
        selectedDate: new DateTime(2019, 9, 10)));
      _rows['6월 31일 (금)'] = items;

      List items2 = [];

      items2.add(new LedgerItem(
          price: -32000,
          category: Category(
              iconId: 4,
              label: _localization.trans('DATING'),
              type: CategoryType.CONSUME),
          memo: 'who1 gave me',
          writer: new User(uid: 'who1@gmail.com'),
          selectedDate: new DateTime(2019, 9, 8)));
      items2.add(new LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, 9, 8)));
      items2.add(new LedgerItem(
        price: 300000,
        category: Category(
            iconId: 18,
            label: _localization.trans('WALLET_MONEY'),
            type: CategoryType.CONSUME),
        selectedDate: new DateTime(2019, 9, 10)));
      items2.add(new LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, 9, 8)));
      items2.add(new LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, 9, 8)));
      items2.add(new LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, 9, 8)));
      items2.add(new LedgerItem(
          price: -12000,
          category: Category(
              iconId: 12,
              label: _localization.trans('PRESENT'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, 9, 8)));
      _rows['6월 25일(수)'] = items2;

      List items3 = [];
      items3.add(new LedgerItem(
          price: -32000,
          category: Category(
              iconId: 4,
              label: _localization.trans('DATING'),
              type: CategoryType.CONSUME),
          memo: 'who1 gave me',
          writer: new User(uid: 'who1@gmail.com'),
          selectedDate: new DateTime(2019, 9, 8)));
      items3.add(new LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, 9, 8)));
      items3.add(new LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, 9, 8)));
      items3.add(new LedgerItem(
          price: -12000,
          category: Category(
              iconId: 12,
              label: _localization.trans('PRESENT'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, 9, 8)));
      _rows['6월 24일(화)'] = items3;

      List items4 = [];
      items4.add(new LedgerItem(
          price: -32000,
          category: Category(
              iconId: 4,
              label: _localization.trans('DATING'),
              type: CategoryType.CONSUME),
          memo: 'who1 gave me',
          writer: new User(uid: 'who1@gmail.com'),
          selectedDate: new DateTime(2019, 9, 8)));
      items4.add(new LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, 9, 8)));
      items4.add(new LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, 9, 8)));
      items4.add(new LedgerItem(
          price: -12000,
          category: Category(
              iconId: 12,
              label: _localization.trans('PRESENT'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, 9, 8)));
      _rows['6월 21일(일)'] = items4;

    });
  }

  Widget _buildLedgerItem(BuildContext context, int index) {
    var keyList = _rows.keys.toList();
    var key = keyList[index];
    var children = <Widget>[];
    _rows[key].forEach((item){
      children.add(new HomeListItem(ledgerItem: item));
    });

    return new Material(
      color: Colors.white,
      child: new StickyHeader(
        header: new Container(
          height: 40.0,
          color: Colors.white,
          padding: new EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          child: new Text(key,
            style: const TextStyle( fontSize: 16, color: Colors.grey),
          ),
        ),
        content: new Container(
          child: Column(
            children: children,
          ),
                
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    Function onAddLedgerList = () => General.instance.navigateScreenNamed(context, '/ledger_item_add');
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
          padding: const EdgeInsets.only(top: 15.0, left: 14.0, right: 14.0),
          child: ListView.builder(
            itemBuilder: _buildLedgerItem,
            itemCount: _rows.length,
          )
        )
      ),
    );
  }
}
