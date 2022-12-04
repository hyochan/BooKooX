import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/models/photo.dart';
import 'package:wecount/screens/category_add.dart';
import 'package:wecount/services/database.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';
import 'package:wecount/widgets/category_list.dart';
import 'package:wecount/widgets/gallery.dart' show Gallery;
import 'package:wecount/widgets/header.dart';
import 'package:wecount/widgets/header.dart' show renderHeaderClose;
import 'package:wecount/utils/asset.dart' as Asset;
import 'package:wecount/utils/db_helper.dart';
import 'package:wecount/utils/localization.dart' show Localization;
import 'package:wecount/utils/logger.dart';

class LedgerItemEdit extends HookWidget {
  const LedgerItemEdit({
    super.key,
    this.title = '',
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    final List<String> choices = ['CONSUME', 'INCOME'];
    final formatCurrency = NumberFormat.simpleCurrency();
    final priceTextEditingController1 = useTextEditingController();
    final priceTextEditingController2 = useTextEditingController();

    var cate = useState<String>("");
    var ledgerItemConsume =
        useState<LedgerItem>(LedgerItem(category: Category(label: "")));
    var ledgerItemIncome =
        useState<LedgerItem>(LedgerItem(category: Category(label: "")));
    var tabController = useTabController(initialLength: 2);
    var categories = useState<List<Category>>([]);
    var localization = Localization.of(context);
    var isLoading = useState<bool>(false);

    void onDatePressed({
      CategoryType categoryType = CategoryType.CONSUME,
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
        if (categoryType == CategoryType.CONSUME) {
          ledgerItemConsume.value = ledgerItemConsume.value.copyWith(
            selectedDate: DateTime(
              pickDate.year,
              pickDate.month,
              pickDate.day,
              pickTime.hour,
              pickTime.minute,
            ),
          );
        } else if (categoryType == CategoryType.INCOME) {
          ledgerItemIncome.value = ledgerItemIncome.value.copyWith(
            selectedDate: DateTime(
              pickDate.year,
              pickDate.month,
              pickDate.day,
              pickTime.hour,
              pickTime.minute,
            ),
          );
        }
      }
    }

    void onLocationPressed({
      CategoryType categoryType = CategoryType.CONSUME,
    }) async {
      Map<String, dynamic>? result =
          await (navigation.navigate(context, AppRoute.locationView.path));

      if (result == null) return;

      if (categoryType == CategoryType.CONSUME) {
        ledgerItemConsume.value =
            ledgerItemConsume.value.copyWith(address: result['address']);
        ledgerItemConsume.value =
            ledgerItemConsume.value.copyWith(latlng: result['latlng']);
      } else if (categoryType == CategoryType.INCOME) {
        ledgerItemIncome.value =
            ledgerItemConsume.value.copyWith(address: result['address']);
        ledgerItemIncome.value =
            ledgerItemConsume.value.copyWith(latlng: result['latlng']);
      }
    }

    void onLedgerItemEditPressed() async {
      if (tabController.index == 0) {
        if (ledgerItemConsume.value.price == null ||
            ledgerItemConsume.value.category?.label == null ||
            ledgerItemConsume.value.selectedDate == null) {
          return;
        }
        isLoading.value = true;
        await DatabaseService()
            .requestCreateLedgerItem(ledgerItemConsume.value.copyWith(
                price: double.parse('-${ledgerItemConsume.value.price}')))
            .then(
              (value) => {
                isLoading.value = false,
                navigation.push(context, AppRoute.homeTab.path),
              },
            );
      } else if (tabController.index == 1) {
        if (ledgerItemIncome.value.price == null ||
            ledgerItemIncome.value.category?.label == null ||
            ledgerItemIncome.value.selectedDate == null) {
          return;
        }
        isLoading.value = true;
        await DatabaseService()
            .requestCreateLedgerItem(ledgerItemIncome.value)
            .then(
              (value) => {
                isLoading.value = false,
                navigation.push(context, AppRoute.homeTab.path),
              },
            );
      }
    }

    void showCategory(
      BuildContext context, {
      CategoryType categoryType = CategoryType.CONSUME,
    }) async {
      var localization = Localization.of(context);
      categories.value = (categoryType == CategoryType.CONSUME
              ? await DBHelper.instance.getConsumeCategories(context)
              : await DBHelper.instance.getIncomeCategories(context))
          .cast<Category>();

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
                lastId: categories.value[categories.value.length - 1].id,
              ),
            );
          },
        );
        if (result != null) {
          categories.value = [...categories.value, result];
        }
      }

      var result = await showModalBottomSheet<Category>(
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
                      '${localization!.trans('CATEGORY')}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.displayLarge!.color,
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
              const SizedBox(height: 8),
              Expanded(
                child: CategoryList(categories: categories.value),
              ),
            ],
          ),
        ),
      );

      if (result != null) {
        if (categoryType == CategoryType.CONSUME) {
          ledgerItemConsume.value = ledgerItemConsume.value.copyWith.category!(
            iconId: result.iconId,
            id: result.id,
            label: result.label,
            type: result.type,
          );
        } else if (categoryType == CategoryType.INCOME) {
          ledgerItemIncome.value = ledgerItemIncome.value.copyWith.category!(
            iconId: result.iconId,
            id: result.id,
            label: result.label,
            type: result.type,
          );
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
                color: Asset.Colors.cloudyBlue,
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
                              ? Theme.of(context).textTheme.displayLarge!.color
                              : Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .color,
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
                                ? Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color
                                : Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .color,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      showDropdown
                          ? const Icon(
                              Icons.arrow_drop_down,
                              color: Asset.Colors.cloudyBlue,
                            )
                          : const SizedBox(),
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
        showCategory(context, categoryType: CategoryType.CONSUME);
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: GestureDetector(
          onTap: () {
            priceTextEditingController1.text =
                formatCurrency.format(ledgerItemConsume.value.price ?? 0.0);
            FocusManager.instance.primaryFocus?.unfocus();
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
                        image: Asset.Icons.icCoins,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Text(
                      localization!.trans('PRICE')!,
                      style: const TextStyle(
                        color: Asset.Colors.cloudyBlue,
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
                        color: Asset.Colors.carnation,
                      )),
                  Expanded(
                    child: TextField(
                      onTap: () {
                        priceTextEditingController1.text =
                            ledgerItemConsume.value.price != null
                                ? ledgerItemConsume.value.price.toString()
                                : "";
                      },
                      textInputAction: TextInputAction.done,
                      onChanged: (String value) {
                        String inputPrice = value.trim();

                        if (inputPrice == "") {
                          ledgerItemConsume.value =
                              ledgerItemConsume.value.copyWith(price: 0);
                        } else {
                          ledgerItemConsume.value = ledgerItemConsume.value
                              .copyWith(price: double.parse(inputPrice));
                        }
                      },
                      onEditingComplete: () {
                        priceTextEditingController1.text = formatCurrency
                            .format(ledgerItemConsume.value.price ?? 0.0);
                      },
                      controller: priceTextEditingController1,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                        hintStyle: TextStyle(color: Asset.Colors.carnation),
                      ),
                      style: const TextStyle(
                        fontSize: 28,
                        color: Asset.Colors.carnation,
                      ),
                    ),
                  ),
                ],
              ),

              /// CATEGORY
              ledgerItemConsume.value.category!.label == ""
                  ? renderBox(
                      margin: const EdgeInsets.only(top: 52),
                      icon: Icons.category,
                      text: localization.trans('CATEGORY')!,
                      showDropdown: true,
                      onPressed: onCategoryPressed,
                    )
                  : renderBox(
                      margin: const EdgeInsets.only(top: 52),
                      image: iconMaps[ledgerItemConsume.value.category!.iconId],
                      text: ledgerItemConsume.value.category!.label,
                      showDropdown: true,
                      onPressed: onCategoryPressed,
                      active: true,
                    ),

              /// SELECTED DATE
              ledgerItemConsume.value.selectedDate == null
                  ? renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.date_range,
                      text: localization.trans('DATE')!,
                      showDropdown: true,
                      onPressed: onDatePressed,
                    )
                  : renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.date_range,
                      text: DateFormat('yyyy-MM-dd hh:mm a')
                          .format(ledgerItemConsume.value.selectedDate!)
                          .toLowerCase(),
                      showDropdown: true,
                      onPressed: onDatePressed,
                      active: true,
                    ),

              /// LOCATION
              ledgerItemConsume.value.address == null
                  ? renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.location_on,
                      text: localization.trans('LOCATION')!,
                      showDropdown: true,
                      onPressed: onLocationPressed,
                    )
                  : renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.location_on,
                      text: ledgerItemConsume.value.address!,
                      showDropdown: false,
                      onPressed: onLocationPressed,
                      active: true,
                    ),
              Gallery(
                margin: const EdgeInsets.only(top: 26),
                pictureProps: [Photo().copyWith(isAddBtn: true)],
                ledgerItem: ledgerItemConsume.value,
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
            priceTextEditingController2.text =
                formatCurrency.format(ledgerItemIncome.value.price ?? 0.0);
            FocusManager.instance.primaryFocus?.unfocus();
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
                        image: Asset.Icons.icCoins,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Text(
                      localization!.trans('PRICE')!,
                      style: const TextStyle(
                        color: Asset.Colors.cloudyBlue,
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
                        color: Theme.of(context).textTheme.displayLarge!.color,
                      )),
                  Expanded(
                    child: TextField(
                      onTap: () {
                        priceTextEditingController2.text =
                            ledgerItemIncome.value.price != null
                                ? ledgerItemIncome.value.price.toString()
                                : "";
                      },
                      textInputAction: TextInputAction.done,
                      onChanged: (String value) {
                        String inputPrice = value.trim();

                        if (inputPrice == "") {
                          ledgerItemIncome.value =
                              ledgerItemIncome.value.copyWith(price: 0);
                        } else {
                          ledgerItemIncome.value = ledgerItemIncome.value
                              .copyWith(price: double.parse(inputPrice));
                        }
                      },
                      onEditingComplete: () {
                        priceTextEditingController2.text = formatCurrency
                            .format(ledgerItemIncome.value.price ?? 0.0);
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
                        color: Asset.Colors.mediumGray,
                      ),
                    ),
                  ),
                ],
              ),

              /// CATEGORY
              ledgerItemIncome.value.category!.label == ""
                  ? renderBox(
                      margin: const EdgeInsets.only(top: 52),
                      icon: Icons.category,
                      text: localization.trans('CATEGORY')!,
                      showDropdown: true,
                      onPressed: onCategoryPressed,
                    )
                  : renderBox(
                      margin: const EdgeInsets.only(top: 52),
                      image: iconMaps[ledgerItemIncome.value.category!.iconId],
                      text: ledgerItemIncome.value.category!.label,
                      showDropdown: true,
                      onPressed: onCategoryPressed,
                      active: true,
                    ),

              /// SELECTED DATE
              ledgerItemIncome.value.selectedDate == null
                  ? renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.date_range,
                      text: localization.trans('DATE')!,
                      showDropdown: true,
                      onPressed: () =>
                          onDatePressed(categoryType: CategoryType.INCOME),
                    )
                  : renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.date_range,
                      text: DateFormat('yyyy-MM-dd hh:mm a')
                          .format(ledgerItemIncome.value.selectedDate!)
                          .toLowerCase(),
                      showDropdown: true,
                      onPressed: () =>
                          onDatePressed(categoryType: CategoryType.INCOME),
                      active: true,
                    ),

              /// LOCATION
              ledgerItemIncome.value.address == null
                  ? renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.location_on,
                      text: localization.trans('LOCATION')!,
                      showDropdown: true,
                      onPressed: () =>
                          onLocationPressed(categoryType: CategoryType.INCOME),
                    )
                  : renderBox(
                      margin: const EdgeInsets.only(top: 8),
                      icon: Icons.location_on,
                      text: ledgerItemIncome.value.address!,
                      showDropdown: false,
                      onPressed: () =>
                          onLocationPressed(categoryType: CategoryType.INCOME),
                      active: true,
                    ),
              Gallery(
                margin: const EdgeInsets.only(top: 26),
                pictureProps: [Photo(isAddBtn: true)],
                ledgerItem: ledgerItemIncome.value,
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          appBar: renderHeaderClose(
            context: context,
            brightness: Theme.of(context).brightness,
            actions: [
              SizedBox(
                width: 56.0,
                child: RawMaterialButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: onLedgerItemEditPressed,
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.add_box,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TabBar(
                    unselectedLabelColor: Asset.Colors.paleGray,
                    isScrollable: true,
                    controller: tabController,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).textTheme.displayLarge!.color!,
                          width: 4.0),
                      insets: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    indicatorColor: Theme.of(context).colorScheme.background,
                    labelColor: Theme.of(context).textTheme.displayLarge!.color,
                    labelStyle: const TextStyle(
                      fontSize: 20,
                    ),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                    tabs: choices.map((String choice) {
                      return Tab(
                        text: localization!.trans(choice),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: choices.map((String choice) {
                      switch (choice) {
                        case 'CONSUME':
                          return renderConsumeView();
                        case 'INCOME':
                          return renderIncomeView();
                      }
                      return const SizedBox();
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isLoading.value)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (isLoading.value)
          Positioned(
            child: CircularProgressIndicator(
              semanticsLabel: Localization.of(context)!.trans('LOADING'),
              backgroundColor: Theme.of(context).primaryColor,
              strokeWidth: 2,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
      ],
    );
  }
}
