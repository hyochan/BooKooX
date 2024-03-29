import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/screens/setting_currency.dart';
import 'package:wecount/screens/members.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/logger.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';
import 'package:wecount/widgets/member_horizontal_list.dart';
import 'package:wecount/services/database.dart' show DatabaseService;
import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/utils/localization.dart';
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/models/currency_model.dart';
import 'package:wecount/models/ledger_model.dart';
import 'package:wecount/utils/colors.dart';
import 'package:provider/provider.dart';

class LedgerEditArguments {
  final LedgerModel? ledger;
  final LedgerEditType mode;

  LedgerEditArguments({this.ledger, this.mode = LedgerEditType.add});
}

enum LedgerEditType {
  add,
  update,
}

class LedgerEdit extends HookWidget {
  final LedgerModel? ledger;
  final LedgerEditType mode;

  const LedgerEdit({
    super.key,
    this.ledger,
    this.mode = LedgerEditType.add,
  });

  @override
  Widget build(BuildContext context) {
    var editLedger = useState<LedgerModel?>(null);
    var loading = useState<bool>(false);
    var titleController = useTextEditingController(text: ledger?.title);
    var descController = useTextEditingController(text: ledger?.description);

    useEffect(() {
      if (ledger == null) {
        editLedger.value = LedgerModel(
          title: '',
          currency: currencies[29],
          color: ColorType.dusk,
          adminIds: [],
          memberIds: [],
        );
        return;
      }
      editLedger.value = ledger;
      return null;
    }, []);

    void onPressCurrency() async {
      var result = await navigation.navigate(
        context,
        AppRoute.settingCurrency.path,
        arguments: SettingCurrencyArguments(
          selectedCurrency: editLedger.value!.currency.currency,
        ),
      );

      if (result == null) return;

      editLedger.value = editLedger.value!.copyWith(currency: result);
    }

    void selectColor(ColorType item) {
      editLedger.value = editLedger.value!.copyWith(color: item);
    }

    void pressDone() async {
      final db = DatabaseService();

      loading.value = true;

      if (editLedger.value!.title.isEmpty) {
        loading.value = false;
        return;
      }

      if (editLedger.value!.description == null ||
          editLedger.value!.description!.isEmpty) {
        loading.value = false;
        return;
      }

      if (mode == LedgerEditType.add) {
        String? refId = '';
        try {
          refId = await db.requestCreateNewLedger(editLedger.value);
          editLedger.value = editLedger.value?.copyWith(id: refId);
        } catch (err) {
          logger.e('err: $err');
        } finally {
          loading.value = false;
        }
        if (context.mounted) {
          Navigator.of(context).pop(editLedger.value);
        }
      } else if (mode == LedgerEditType.update) {
        try {
          await db.requestUpdateLedger(editLedger.value);
        } catch (err) {
          logger.e('err: $err');
        } finally {
          loading.value = false;
        }
        if (context.mounted) {
          Navigator.of(context).pop(editLedger.value?.id);
        }
      }
    }

    void leaveLedger() async {
      User? user = FirebaseAuth.instance.currentUser;
      bool hasOwnerPermission =
          user != null && editLedger.value?.ownerId == user.uid;
      bool hasMoreThanOneUser = editLedger.value!.memberIds.length > 1;

      if (hasOwnerPermission && !hasMoreThanOneUser) {
        General.instance.showConfirmDialog(
          context,
          title: Text(localization(context).notification),
          content: Text(localization(context).leaveAsk),
          cancelPressed: () => Navigator.of(context).pop(),
          okPressed: () async {
            bool hasLeft = await DatabaseService()
                .requestLeaveLedger(editLedger.value!.id);
            var ledger = await DatabaseService().fetchSelectedLedger();
            if (context.mounted) {
              Provider.of<CurrentLedger>(context, listen: false)
                  .setLedger(ledger);
              Navigator.of(context).pop();
              Navigator.of(context).pop(editLedger.value!.id);
            }
          },
        );
        return;
      }

      General.instance.showSingleDialog(
        context,
        title: Text(localization(context).error),
        content: Text(localization(context).shouldTransferOwnership),
      );
    }

    return Scaffold(
      backgroundColor: asset.Colors.getColor(editLedger.value!.color),
      appBar: renderHeaderBack(
        context: context,
        brightness: Brightness.dark,
        actions: [
          ledger == null
              ? const SizedBox()
              : Container(
                  width: 56.0,
                  margin: const EdgeInsets.only(right: 16),
                  child: RawMaterialButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: leaveLedger,
                    child: Text(
                      localization(context).leave,
                      semanticsLabel: localization(context).leave,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 40, left: 40, right: 40),
                  child: TextField(
                    controller: titleController,
                    maxLines: 1,
                    onChanged: (String txt) {
                      editLedger.value = editLedger.value!.copyWith(title: txt);
                    },
                    decoration: InputDecoration(
                      hintMaxLines: 2,
                      border: InputBorder.none,
                      hintText: localization(context).ledgerNameHint,
                      hintStyle: const TextStyle(
                        fontSize: 28.0,
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 24, left: 40, right: 40, bottom: 20),
                  height: 160,
                  child: TextField(
                    controller: descController,
                    maxLines: 8,
                    onChanged: (String txt) {
                      editLedger.value =
                          editLedger.value!.copyWith(description: txt);
                    },
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: localization(context).ledgerDescriptionHint,
                      hintStyle: const TextStyle(
                        fontSize: 16.0,
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: onPressCurrency,
                  child: Container(
                    height: 80.0,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 40.0, right: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          localization(context).currency,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '${editLedger.value!.currency.currency} | ${editLedger.value!.currency.symbol}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              size: 16,
                              color: Color.fromRGBO(255, 255, 255, 0.7),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: Colors.white70),
                Container(
                  height: 80.0,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        localization(context).color,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(right: 32),
                          child: ListView.builder(
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: colorItems.length,
                            itemExtent: 32,
                            itemBuilder: (context, index) {
                              final item =
                                  colorItems[colorItems.length - index - 1];
                              bool selected = item == editLedger.value!.color;
                              return ColorItem(
                                color: item,
                                onTap: () => selectColor(item),
                                selected: selected,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white70),
                MemberHorizontalList(
                  showAddBtn: true,
                  memberIds: ledger != null ? ledger!.memberIds : [],
                  onSeeAllPressed: () => navigation.navigate(
                    context,
                    AppRoute.members.path,
                    arguments: MembersArguments(ledger: ledger),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: SizedBox(
                height: 60,
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.0),
                      ),
                    ),
                  ),
                  onPressed: pressDone,
                  child: loading.value
                      ? SizedBox(
                          height: 52,
                          width: 80,
                          child: Center(
                            child: CircularProgressIndicator(
                              semanticsLabel: localization(context).loading,
                              backgroundColor: Theme.of(context).primaryColor,
                              strokeWidth: 2,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          ),
                        )
                      : Container(
                          height: 52,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Center(
                            child: Text(
                              ledger == null
                                  ? localization(context).done
                                  : localization(context).update,
                              style: TextStyle(
                                color: asset.Colors.getColor(
                                    editLedger.value!.color),
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorItem extends StatelessWidget {
  const ColorItem({
    Key? key,
    this.color,
    this.selected,
    this.onTap,
  }) : super(key: key);
  final ColorType? color;
  final bool? selected;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ClipOval(
          child: Material(
            clipBehavior: Clip.hardEdge,
            color: asset.Colors.getColor(color),
            child: InkWell(
              onTap: onTap as void Function()?,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        selected == true
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              )
            : const SizedBox()
      ],
    );
  }
}
