import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import '../shared/header.dart';
import '../utils/asset.dart' as Asset;
import '../models/LedgerItem.dart' show LedgerItem;
import '../shared/header.dart' show renderHeaderClose;
import '../utils/localization.dart' show Localization;

class LedgerItemAdd extends StatefulWidget {
  LedgerItemAdd({
    Key key,
    this.title = '',
  }) : super(key: key);
  final String title;

  @override
  _LedgerItemAddState createState() => new _LedgerItemAddState();
}
 
class _LedgerItemAddState extends State<LedgerItemAdd> with TickerProviderStateMixin {
  final List<String> choices = ['CONSUME', 'INCOME'];
  final formatCurrency = NumberFormat.simpleCurrency();
  final TextEditingController priceTextEditingController1 = TextEditingController(
    text: '0',
  );
  final TextEditingController priceTextEditingController2 = TextEditingController(
    text: '0',
  );

  LedgerItem _ledgerItemIncome = LedgerItem();
  LedgerItem _ledgerItemConsume = LedgerItem();
  TabController _tabController;

  void onCategoryPressed () {
    print('onCategoryPressed');
  }

  void onDatePressed () {

  }

  void onLocationPressed () {

  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    if (_tabController != null) {
      _tabController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);

    Widget renderBox({
      EdgeInsets margin = const EdgeInsets.only(top: 8.0),
      IconData icon = Icons.category,
      String text = '',
      bool showDropdown = true,
      Function onPressed,
    }) {
      return Container(
        margin: margin,
        child: FlatButton(
          color: Theme.of(context).backgroundColor,
          onPressed: onPressed,
          padding: EdgeInsets.all(0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 56,
            decoration: BoxDecoration(
              border: Border.all(
                color: Asset.Colors.cloudyBlue,
                width: 1.0,
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Icon(
                    icon,
                    color: Asset.Colors.cloudyBlue,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            text,
                            style: TextStyle(
                              color: Asset.Colors.cloudyBlue,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        showDropdown
                        ? Icon(
                            Icons.arrow_drop_down,
                            color: Asset.Colors.cloudyBlue,
                          )
                        : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget renderIncomeView() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: GestureDetector(
          onTap: () {
            priceTextEditingController2.text = '${formatCurrency.format(_ledgerItemIncome.price ?? 0.0)}';
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            children: <Widget>[
              /// PRICE
              Container(
                margin: EdgeInsets.only(top: 44),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Image(
                        image: Asset.Icons.icCoins,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Text(
                      _localization.trans('PRICE'),
                      style: TextStyle(
                        color: Asset.Colors.cloudyBlue,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              /// PRICE INPUT
              Container(
                child: TextField(
                  textInputAction: TextInputAction.done,
                  onChanged: (String value) => _ledgerItemIncome.price = double.parse(value),
                  onTap: () {
                    priceTextEditingController2.text = '${_ledgerItemIncome.price ?? 0.0}';
                  },
                  onEditingComplete: () {
                    priceTextEditingController2.text = '${formatCurrency.format(_ledgerItemIncome.price ?? 0.0)}';
                  },
                  controller: priceTextEditingController2,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0',
                  ),
                  style: TextStyle(
                    fontSize: 28,
                    color: Asset.Colors.mediumGray,
                  ),
                ),
              ),
              /// CATEGORY
              renderBox(
                margin: EdgeInsets.only(top: 52),
                icon: Icons.category,
                text: _localization.trans('CATEGORY'),
                showDropdown: true,
                onPressed: onCategoryPressed,
              ),
              /// SELECTED DATE
              renderBox(
                margin: EdgeInsets.only(top: 8),
                icon: Icons.date_range,
                text: _localization.trans('DATE'),
                showDropdown: true,
                onPressed: onDatePressed,
              ),
              /// LOCATION
              renderBox(
                margin: EdgeInsets.only(top: 8),
                icon: Icons.location_on,
                text: _localization.trans('LOCATION'),
                showDropdown: false,
                onPressed: onLocationPressed,
              ),
              /// PICTURE
              Container(
                margin: EdgeInsets.only(top: 26),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 18),
                      width: 20.0,
                      child: Icon(
                        Icons.photo,
                        color: Asset.Colors.cloudyBlue,
                      ),
                    ),
                    Text(
                      _localization.trans('PICTURE'),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.title.color,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              /// PICTURE LIST
            ],
          ),
        ),
      );
    }

    Widget renderConsumeView() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: GestureDetector(
          onTap: () {
            priceTextEditingController1.text = '${formatCurrency.format(_ledgerItemConsume.price ?? 0.0)}';
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            children: <Widget>[
              /// PRICE
              Container(
                margin: EdgeInsets.only(top: 44),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Image(
                        image: Asset.Icons.icCoins,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Text(
                      _localization.trans('PRICE'),
                      style: TextStyle(
                        color: Asset.Colors.cloudyBlue,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              /// PRICE INPUT
              Container(
                child: TextField(
                  textInputAction: TextInputAction.done,
                  onChanged: (String value) => _ledgerItemConsume.price = double.parse(value),
                  onTap: () {
                    priceTextEditingController1.text = '${_ledgerItemConsume.price ?? 0.0}';
                  },
                  onEditingComplete: () {
                    priceTextEditingController1.text = '${formatCurrency.format(_ledgerItemConsume.price ?? 0.0)}';
                  },
                  controller: priceTextEditingController1,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0',
                  ),
                  style: TextStyle(
                    fontSize: 28,
                    color: Asset.Colors.mediumGray,
                  ),
                ),
              ),
              /// CATEGORY
              renderBox(
                margin: EdgeInsets.only(top: 52),
                icon: Icons.category,
                text: _localization.trans('CATEGORY'),
                showDropdown: true,
                onPressed: onCategoryPressed,
              ),
              /// SELECTED DATE
              renderBox(
                margin: EdgeInsets.only(top: 8),
                icon: Icons.date_range,
                text: _localization.trans('DATE'),
                showDropdown: true,
                onPressed: onDatePressed,
              ),
              /// LOCATION
              renderBox(
                margin: EdgeInsets.only(top: 8),
                icon: Icons.location_on,
                text: _localization.trans('LOCATION'),
                showDropdown: false,
                onPressed: onLocationPressed,
              ),
              /// PICTURE
              Container(
                margin: EdgeInsets.only(top: 26),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 18),
                      width: 20.0,
                      child: Icon(
                        Icons.photo,
                        color: Asset.Colors.cloudyBlue,
                      ),
                    ),
                    Text(
                      _localization.trans('PICTURE'),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.title.color,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              /// PICTURE LIST
            ],
          ),
        ),
      );
    }


    return Scaffold(
      appBar: renderHeaderClose(
        context: context,
        brightness: Theme.of(context).brightness,
        actions: [
          Container(
            width: 56.0,
            child: RawMaterialButton(
              padding: EdgeInsets.all(0.0),
              shape: CircleBorder(),
              onPressed: () {},
              child: Icon(
                Icons.add_box,
                color: Theme.of(context).textTheme.title.color,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: TabBar(
                unselectedLabelColor: Asset.Colors.paleGray,
                isScrollable: true,
                controller: _tabController,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Asset.Colors.dusk, width: 4.0),
                  insets: EdgeInsets.symmetric(horizontal: 8),
                  // insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                ),
                indicatorColor: Theme.of(context).backgroundColor,
                labelColor: Asset.Colors.dusk,
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                labelPadding: EdgeInsets.symmetric(horizontal: 8),
                // indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
                tabs: choices.map((String choice) {
                  return Container(
                    child: Tab(
                      text: _localization.trans(choice),
                    ),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: choices.map((String choice) {
                  switch (choice) {
                    case 'CONSUME':
                      return renderConsumeView();
                      break;
                    case 'INCOME':
                      return renderIncomeView();
                      break;
                  }
                  return Container();
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
