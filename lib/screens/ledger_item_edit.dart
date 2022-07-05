import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wecount/models/category_model.dart';
import 'package:wecount/models/ledger_item.dart' show LedgerItemModel;
import 'package:wecount/models/photo_model.dart' show PhotoModel;
import 'package:wecount/screens/category_add.dart';
import 'package:wecount/screens/location_view.dart';
import 'package:wecount/shared/category_list.dart';
import 'package:wecount/shared/gallery.dart' show Gallery;
import 'package:wecount/shared/header.dart';
import 'package:wecount/shared/header.dart' show renderHeaderClose;
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/db_helper.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/logger.dart';

import '../utils/localization.dart';

class LedgerItemEdit extends StatefulWidget {
  static const String name = '/ledger_item_edit';

  const LedgerItemEdit({
    Key? key,
  }) : super(key: key);

  @override
  State<LedgerItemEdit> createState() => _LedgerItemEditState();
}

class _LedgerItemEditState extends State<LedgerItemEdit>
    with TickerProviderStateMixin {
  final List<String> choices = ['CONSUME', 'INCOME'];
  final formatCurrency = NumberFormat.simpleCurrency();
  final TextEditingController priceTextEditingController1 =
      TextEditingController(
    text: '0',
  );
  final TextEditingController priceTextEditingController2 =
      TextEditingController(
    text: '0',
  );

  final LedgerItemModel _ledgerItemIncome = LedgerItemModel();
  final LedgerItemModel _ledgerItemConsume = LedgerItemModel();
  TabController? _tabController;
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
      _tabController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onDatePressed({
      CategoryType categoryType = CategoryType.consume,
    }) async {
      int year = DateTime.now().year;
      int prevDate = year - 100;
      int lastDate = year + 10;
      DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(prevDate),
        lastDate: DateTime(lastDate),
      );
      TimeOfDay? pickTime;
      if (pickDate != null) {
        pickTime = await showTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 0, minute: 0),
        );
      }
      if (pickDate != null && pickTime != null) {
        if (categoryType == CategoryType.consume) {
          setState(() => _ledgerItemConsume.selectedDate = DateTime(
                pickDate.year,
                pickDate.month,
                pickDate.day,
                pickTime!.hour,
                pickTime.minute,
              ));
        } else if (categoryType == CategoryType.income) {
          setState(() => _ledgerItemIncome.selectedDate = DateTime(
                pickDate.year,
                pickDate.month,
                pickDate.day,
                pickTime!.hour,
                pickTime.minute,
              ));
        }
      }
    }

    void onLocationPressed({
      CategoryType categoryType = CategoryType.consume,
    }) async {
      Map<String, dynamic>? result = await (General.instance.navigateScreen(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LocationView(),
        ),
      ));

      if (result == null) return;

      if (categoryType == CategoryType.consume) {
        setState(() {
          _ledgerItemConsume.address = result['address'];
          _ledgerItemConsume.latlng = result['latlng'];
        });
      } else if (categoryType == CategoryType.income) {
        setState(() {
          _ledgerItemIncome.address = result['address'];
          _ledgerItemIncome.latlng = result['latlng'];
        });
      }
    }

    void onLedgerItemEditPressed() {
      logger.i('onLedgerItemEditPressed');
      logger.d(_ledgerItemConsume.toString());
    }

    void showCategory(
      BuildContext context, {
      CategoryType categoryType = CategoryType.consume,
    }) async {
      categories = categoryType == CategoryType.consume
          ? await DBHelper.instance.getConsumeCategories(context)
          : await DBHelper.instance.getIncomeCategories(context);

      void onClosePressed() {
        Navigator.of(context).pop();
      }

      void onAddPressed(CategoryType categoryType) async {
        var result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
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

      var result = await showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: onClosePressed,
                      icon: const Icon(Icons.close),
                    ),
                    Text(
                      t('CATEGORY'),
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.headline1!.color,
                      ),
                    ),
                    IconButton(
                      onPressed: () => onAddPressed(categoryType),
                      icon: const Icon(Icons.add),
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

      if (result != null) {
        if (categoryType == CategoryType.consume) {
          setState(() => _ledgerItemConsume.category = result);
        } else if (categoryType == CategoryType.income) {
          setState(() => _ledgerItemIncome.category = result);
        }
      }
    }

    Widget renderBox({
      EdgeInsets margin = const EdgeInsets.only(top: 8.0),
      IconData icon = Icons.category,
      AssetImage? image,
      String text = '',
      bool showDropdown = true,
      bool active = false,
      required void Function() onPressed,
    }) {
      return Container(
        margin: margin,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 56,
            decoration: BoxDecoration(
              border: Border.all(
                color: cloudyBlueColor,
                width: 1.0,
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: image == null
                      ? Icon(
                          icon,
                          color: active
                              ? Theme.of(context).textTheme.headline1!.color
                              : Theme.of(context).textTheme.headline2!.color,
                        )
                      : Image(
                          image: image,
                          width: 20,
                          height: 20,
                        ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: AutoSizeText(
                          text,
                          style: TextStyle(
                            color: active == true
                                ? Theme.of(context).textTheme.headline1!.color
                                : Theme.of(context).textTheme.headline2!.color,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      showDropdown
                          ? const Icon(
                              Icons.arrow_drop_down,
                              color: cloudyBlueColor,
                            )
                          : Container(),
                    ],
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
        showCategory(context, categoryType: CategoryType.consume);
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: GestureDetector(
          onTap: () {
            priceTextEditingController1.text =
                formatCurrency.format(_ledgerItemConsume.price ?? 0.0);
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            children: <Widget>[
              /// PRICE
              Container(
                margin: const EdgeInsets.only(top: 44),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: Image(
                        image: asset.Icons.icCoins,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Text(
                      t('PRICE'),
                      style: const TextStyle(
                        color: cloudyBlueColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              /// PRICE INPUT
              Row(
                children: <Widget>[
                  const Text('- ',
                      style: TextStyle(
                        fontSize: 28,
                        color: carnationColor,
                      )),
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      onChanged: (String value) {
                        String inputPrice = value.trim();

                        if (inputPrice == "") {
                          _ledgerItemConsume.price = 0;
                        } else {
                          _ledgerItemConsume.price = double.parse(value);
                        }
                      },
                      onTap: () {
                        priceTextEditingController1.text =
                            '${_ledgerItemConsume.price ?? 0.0}';
                      },
                      onEditingComplete: () {
                        priceTextEditingController1.text = formatCurrency
                            .format(_ledgerItemConsume.price ?? 0.0);
                      },
                      controller: priceTextEditingController1,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                      ),
                      style: const TextStyle(
                        fontSize: 28,
                        color: carnationColor,
                      ),
                    ),
                  ),
                ],
              ),

              /// CATEGORY
              _ledgerItemConsume.category == null
                  ? renderBox(
                      margin: const EdgeInsets.only(top: 52),
                      icon: Icons.category,
                      text: t('CATEGORY'),
                      showDropdown: true,
                      onPressed: onCategoryPressed,
                    )
                  : renderBox(
                      margin: const EdgeInsets.only(top: 52),
                      image: iconMaps[_ledgerItemConsume.category!.iconId!],
                      text: _ledgerItemConsume.category!.label!,
                      showDropdown: true,
                      onPressed: onCategoryPressed,
                      active: true,
                    ),

              /// SELECTED DATE
              _ledgerItemConsume.selectedDate == null
                  ? renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.date_range,
                      text: t('DATE'),
                      showDropdown: true,
                      onPressed: onDatePressed,
                    )
                  : renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.date_range,
                      text: DateFormat('yyyy-MM-dd hh:mm a')
                          .format(_ledgerItemConsume.selectedDate!)
                          .toLowerCase(),
                      showDropdown: true,
                      onPressed: onDatePressed,
                      active: true,
                    ),

              /// LOCATION
              _ledgerItemConsume.address == null
                  ? renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.location_on,
                      text: t('LOCATION'),
                      showDropdown: true,
                      onPressed: onLocationPressed,
                    )
                  : renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.location_on,
                      text: _ledgerItemConsume.address!,
                      showDropdown: false,
                      onPressed: onLocationPressed,
                      active: true,
                    ),
              Gallery(
                margin: const EdgeInsets.only(top: 26),
                pictures: [PhotoModel(isAddBtn: true)],
                ledgerItem: _ledgerItemConsume,
              ),
            ],
          ),
        ),
      );
    }

    Widget renderIncomeView() {
      void onCategoryPressed() {
        showCategory(context, categoryType: CategoryType.income);
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: GestureDetector(
          onTap: () {
            priceTextEditingController2.text =
                formatCurrency.format(_ledgerItemIncome.price ?? 0.0);
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            children: <Widget>[
              /// PRICE
              Container(
                margin: const EdgeInsets.only(top: 44),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: Image(
                        image: asset.Icons.icCoins,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Text(
                      t('PRICE'),
                      style: const TextStyle(
                        color: cloudyBlueColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              /// PRICE INPUT
              Row(
                children: <Widget>[
                  Text('+ ',
                      style: TextStyle(
                        fontSize: 28,
                        color: Theme.of(context).textTheme.headline1!.color,
                      )),
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      onChanged: (String value) {
                        String inputPrice = value.trim();

                        if (inputPrice == "") {
                          _ledgerItemIncome.price = 0;
                        } else {
                          _ledgerItemIncome.price = double.parse(value);
                        }
                      },
                      onTap: () {
                        priceTextEditingController2.text =
                            '${_ledgerItemIncome.price ?? 0.0}';
                      },
                      onEditingComplete: () {
                        priceTextEditingController2.text = formatCurrency
                            .format(_ledgerItemIncome.price ?? 0.0);
                      },
                      controller: priceTextEditingController2,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                      ),
                      style: const TextStyle(
                        fontSize: 28,
                        color: mediumGrayColor,
                      ),
                    ),
                  ),
                ],
              ),

              /// CATEGORY
              _ledgerItemIncome.category == null
                  ? renderBox(
                      margin: const EdgeInsets.only(top: 52),
                      icon: Icons.category,
                      text: t('CATEGORY'),
                      showDropdown: true,
                      onPressed: onCategoryPressed,
                    )
                  : renderBox(
                      margin: const EdgeInsets.only(top: 52),
                      image: iconMaps[_ledgerItemIncome.category!.iconId!],
                      text: _ledgerItemIncome.category!.label!,
                      showDropdown: true,
                      onPressed: onCategoryPressed,
                      active: true,
                    ),

              /// SELECTED DATE
              _ledgerItemIncome.selectedDate == null
                  ? renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.date_range,
                      text: t('DATE'),
                      showDropdown: true,
                      onPressed: () =>
                          onDatePressed(categoryType: CategoryType.income),
                    )
                  : renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.date_range,
                      text: DateFormat('yyyy-MM-dd hh:mm a')
                          .format(_ledgerItemIncome.selectedDate!)
                          .toLowerCase(),
                      showDropdown: true,
                      onPressed: () =>
                          onDatePressed(categoryType: CategoryType.income),
                      active: true,
                    ),

              /// LOCATION
              _ledgerItemIncome.address == null
                  ? renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.location_on,
                      text: t('LOCATION'),
                      showDropdown: true,
                      onPressed: () =>
                          onLocationPressed(categoryType: CategoryType.income),
                    )
                  : renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.location_on,
                      text: _ledgerItemIncome.address!,
                      showDropdown: false,
                      onPressed: () =>
                          onLocationPressed(categoryType: CategoryType.income),
                      active: true,
                    ),
              Gallery(
                margin: const EdgeInsets.only(top: 26),
                pictures: [PhotoModel(isAddBtn: true)],
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
          SizedBox(
            width: 56.0,
            child: RawMaterialButton(
              padding: const EdgeInsets.all(0.0),
              shape: const CircleBorder(),
              onPressed: onLedgerItemEditPressed,
              child: Icon(
                Icons.add_box,
                color: Theme.of(context).textTheme.headline1!.color,
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
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TabBar(
                unselectedLabelColor: paleGrayColor,
                isScrollable: true,
                controller: _tabController,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      color: Theme.of(context).textTheme.headline1!.color!,
                      width: 4.0),
                  insets: const EdgeInsets.symmetric(horizontal: 8),
                  // insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                ),
                indicatorColor: Theme.of(context).backgroundColor,
                labelColor: Theme.of(context).textTheme.headline1!.color,
                labelStyle: const TextStyle(
                  fontSize: 20,
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                // indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
                tabs: choices.map((String choice) {
                  return Tab(
                    text: t(choice),
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
                    case 'INCOME':
                      return renderIncomeView();
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
