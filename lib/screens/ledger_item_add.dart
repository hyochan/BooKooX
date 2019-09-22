import 'package:bookoo2/screens/location_view.dart';
import 'package:bookoo2/utils/general.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:bookoo2/models/Category.dart';
import 'package:bookoo2/utils/db_helper.dart';
import 'package:bookoo2/screens/category_add.dart';
import 'package:bookoo2/shared/category_list.dart';
import 'package:bookoo2/shared/header.dart';
import 'package:bookoo2/models/Photo.dart' show Photo;
import 'package:bookoo2/models/LedgerItem.dart' show LedgerItem;
import 'package:bookoo2/shared/header.dart' show renderHeaderClose;
import 'package:bookoo2/shared/gallery.dart' show Gallery;
import 'package:bookoo2/utils/asset.dart' as Asset;
import 'package:bookoo2/utils/localization.dart' show Localization;

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
  List<Category> categories = [];

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

    void onDatePressed({
      CategoryType categoryType = CategoryType.CONSUME,
    }) async {
      int year = DateTime.now().year;
      int prevDate = year - 100;
      int lastDate = year + 10;
      DateTime pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(prevDate),
        lastDate: DateTime(lastDate),
      );
      TimeOfDay pickTime;
      if (pickDate != null) {
        pickTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: 0, minute: 0),
        );
      }
      if (pickDate != null && pickTime != null) {
        if (categoryType == CategoryType.CONSUME) {
          setState(() => _ledgerItemConsume.selectedDate = DateTime(
            pickDate.year, pickDate.month, pickDate.day,
            pickTime.hour, pickTime.minute,
          ));
        } else if (categoryType == CategoryType.INCOME) {
          setState(() => _ledgerItemIncome.selectedDate = DateTime(
            pickDate.year, pickDate.month, pickDate.day,
            pickTime.hour, pickTime.minute,
          ));
        }
      }
    }

    void onLocationPressed({
      CategoryType categoryType = CategoryType.CONSUME,
    }) async {
      Map<String, dynamic> result = await General.instance.navigateScreen(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LocationView()),
      );

      if (categoryType == CategoryType.CONSUME) {
        setState(() {
          _ledgerItemConsume.address = result['address'];
          _ledgerItemConsume.latlng = result['latlng'];
        });
      } else if (categoryType == CategoryType.INCOME) {
        setState(() {
          _ledgerItemIncome.address = result['address'];
          _ledgerItemIncome.latlng = result['latlng'];
        });
      }
    }

    void onLedgerItemAddPressed() {
      print('onLedgerItemAddPressed');
      print('${_ledgerItemConsume.toString()}');
    }

    void showCategory(BuildContext context, {
      CategoryType categoryType = CategoryType.CONSUME,
    }) async {
      var _localization = Localization.of(context);
      categories = categoryType == CategoryType.CONSUME
        ? await DbHelper.instance.getConsumeCategories(context)
        : await DbHelper.instance.getIncomeCategories(context);

      void onClosePressed() {
        Navigator.of(context).pop();
      }

      void onAddPressed(CategoryType categoryType) async {
        var result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: CategoryAdd(
                categoryType: categoryType,
                lastId: categories[categories.length - 1].id,
              ),
            );
          },
        );
        if (result != null) {
          setState(() => categories.add(result));
        }
      }

      var _result = await showModalBottomSheet(
        context: context,
        builder: (context) => Container(
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
                      '${_localization.trans('CATEGORY')}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.title.color,
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(0),
                      shape: CircleBorder(),
                      onPressed: () => onAddPressed(categoryType),
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
                child: CategoryList(categories: categories),
              ),
            ],
          ),
        ),
      );
      
      if (_result != null) {
        if (categoryType == CategoryType.CONSUME) {
          setState(() => _ledgerItemConsume.category = _result);
        } else if (categoryType == CategoryType.INCOME) {
          setState(() => _ledgerItemIncome.category = _result);
        }
      }
    }

    Widget renderBox({
      EdgeInsets margin = const EdgeInsets.only(top: 8.0),
      IconData icon = Icons.category,
      AssetImage image,
      String text = '',
      bool showDropdown = true,
      bool active = false,
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
                  child: image == null ? Icon(
                    icon,
                    color: active
                      ? Theme.of(context).textTheme.title.color
                      : Theme.of(context).textTheme.subtitle.color,
                  ) : Image(
                    image: image,
                    width: 20,
                    height: 20,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: AutoSizeText(
                            text,
                            style: TextStyle(
                              color: active == true
                                ? Theme.of(context).textTheme.title.color
                                : Theme.of(context).textTheme.subtitle.color,
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
              _ledgerItemConsume.category == null ? renderBox(
                margin: EdgeInsets.only(top: 52),
                icon: Icons.category,
                text: _localization.trans('CATEGORY'),
                showDropdown: true,
                onPressed: onCategoryPressed,
              ) : renderBox(
                margin: EdgeInsets.only(top: 52),
                image: iconMaps[_ledgerItemConsume.category.iconId],
                text: _ledgerItemConsume.category.label,
                showDropdown: true,
                onPressed: onCategoryPressed,
                active: true,
              ),
              /// SELECTED DATE
              _ledgerItemConsume.selectedDate == null ? renderBox(
                margin: EdgeInsets.only(top: 8),
                icon: Icons.date_range,
                text: _localization.trans('DATE'),
                showDropdown: true,
                onPressed: onDatePressed,
              ) : renderBox(
                margin: EdgeInsets.only(top: 8),
                icon: Icons.date_range,
                text: DateFormat('yyyy-MM-dd hh:mm a').format(_ledgerItemConsume.selectedDate).toLowerCase(),
                showDropdown: true,
                onPressed: onDatePressed,
                active: true,
              ),
              /// LOCATION
              _ledgerItemConsume.address == null ? renderBox(
                margin: EdgeInsets.only(top: 8),
                icon: Icons.date_range,
                text: _localization.trans('LOCATION'),
                showDropdown: true,
                onPressed: onLocationPressed,
              ) : renderBox(
                margin: EdgeInsets.only(top: 8),
                icon: Icons.location_on,
                text: '${_ledgerItemConsume.address.subAdminArea}, ${_ledgerItemConsume.address.thoroughfare}, ${_ledgerItemConsume.address.subThoroughfare}',
                showDropdown: false,
                onPressed: onLocationPressed,
                active: true,
              ),
              Gallery(
                margin: EdgeInsets.only(top: 26),
                showAddBtn: true,
                picture: [Photo(isAddBtn: true)],
                ledgerItem: _ledgerItemConsume,
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
              _ledgerItemIncome.category == null ? renderBox(
                margin: EdgeInsets.only(top: 52),
                icon: Icons.category,
                text: _localization.trans('CATEGORY'),
                showDropdown: true,
                onPressed: onCategoryPressed,
              ) : renderBox(
                margin: EdgeInsets.only(top: 52),
                image: iconMaps[_ledgerItemIncome.category.iconId],
                text: _ledgerItemIncome.category.label,
                showDropdown: true,
                onPressed: onCategoryPressed,
                active: true,
              ),
              /// SELECTED DATE
              _ledgerItemIncome.selectedDate == null ? renderBox(
                margin: EdgeInsets.only(top: 8),
                icon: Icons.date_range,
                text: _localization.trans('DATE'),
                showDropdown: true,
                onPressed: () => onDatePressed(categoryType: CategoryType.INCOME),
              ) : renderBox(
                margin: EdgeInsets.only(top: 8),
                icon: Icons.date_range,
                text: DateFormat('yyyy-MM-dd hh:mm a').format(_ledgerItemIncome.selectedDate).toLowerCase(),
                showDropdown: true,
                onPressed: () => onDatePressed(categoryType: CategoryType.INCOME),
                active: true,
              ),
              /// LOCATION
              _ledgerItemIncome.address == null ? renderBox(
                margin: EdgeInsets.only(top: 8),
                icon: Icons.date_range,
                text: _localization.trans('LOCATION'),
                showDropdown: true,
                onPressed: () => onLocationPressed(categoryType: CategoryType.INCOME),
              ) : renderBox(
                margin: EdgeInsets.only(top: 8),
                icon: Icons.location_on,
                text: '${_ledgerItemIncome.address.subAdminArea}, ${_ledgerItemIncome.address.thoroughfare}, ${_ledgerItemIncome.address.subLocality}',
                showDropdown: false,
                onPressed: () => onLocationPressed(categoryType: CategoryType.INCOME),
                active: true,
              ),
              Gallery(
                margin: EdgeInsets.only(top: 26),
                showAddBtn: true,
                picture: [Photo(isAddBtn: true)],
                ledgerItem: _ledgerItemIncome,
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
