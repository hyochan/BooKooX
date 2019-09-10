import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'package:bookoo2/models/Category.dart';
import 'package:bookoo2/shared/category_item.dart';
import 'package:bookoo2/utils/db_helper.dart';
import '../shared/header.dart';
import '../models/Photo.dart' show Photo;
import '../models/LedgerItem.dart' show LedgerItem;
import '../shared/header.dart' show renderHeaderClose;
import '../shared/gallery.dart' show Gallery;
import '../utils/asset.dart' as Asset;
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

    void onDatePressed() {

    }

    void onLocationPressed() {

    }

    void onLedgerItemAddPressed() {

    }

    void showCategory(BuildContext context, {
      CategoryType categoryType = CategoryType.CONSUME,
    }) async {
      var _localization = Localization.of(context);
      List<Category> categories = categoryType == CategoryType.CONSUME
        ? await DbHelper.instance.getConsumeCategories(context)
        : await DbHelper.instance.getIncomeCategories(context);

      void onClosePressed() {
        Navigator.of(context).pop();
      }

      void onAddPressed() {

      }

      Widget renderCategory(Category category) {
        return CategoryItem(category: category);
      }

      showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            padding: EdgeInsets.only(top: 8),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        shape: CircleBorder(),
                        onPressed: onClosePressed,
                        child: Container(
                          child: Icon(Icons.close),
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Text(
                        _localization.trans('CATEGORY'),
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.title.color,
                        ),
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        shape: CircleBorder(),
                        onPressed: onAddPressed,
                        child: Container(
                          child: Icon(Icons.add),
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: Theme.of(context).dividerColor),
                Container(height: 8),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: categories.map((Category category) {
                          return renderCategory(category);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      );
    }

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

    Widget renderConsumeView() {
      void onCategoryPressed() {
        print('onCategoryPressed');
        showCategory(context, categoryType: CategoryType.CONSUME);
      }

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
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text('- ', style: TextStyle(
                        fontSize: 28,
                        color: Asset.Colors.carnation,
                      )),
                    ),
                    Expanded(
                      child: Container(
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
                            color: Asset.Colors.carnation,
                          ),
                        ),
                      ),
                    ),
                  ],
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
              Gallery(
                margin: EdgeInsets.only(top: 26),
                showAddBtn: true,
                picture: [Photo(isAddBtn: true)],
              ),
            ],
          ),
        ),
      );
    }

    Widget renderIncomeView() {
      void onCategoryPressed() {
        showCategory(context, categoryType: CategoryType.INCOME);
      }

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
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text('+ ', style: TextStyle(
                        fontSize: 28,
                        color: Asset.Colors.mediumGray,
                      )),
                    ),
                    Expanded(
                      child: Container(
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
                    ),
                  ],
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
              Gallery(
                margin: EdgeInsets.only(top: 26),
                showAddBtn: true,
                picture: [Photo(isAddBtn: true)],
              ),
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
              onPressed: onLedgerItemAddPressed,
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
