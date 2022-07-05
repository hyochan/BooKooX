import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecount/models/currency_model.dart';
import 'package:wecount/models/ledger_model.dart';
import 'package:wecount/screens/empty.dart';
import 'package:wecount/screens/members.dart';
import 'package:wecount/screens/setting_currency.dart';
import 'package:wecount/services/database.dart' show DatabaseService;
import 'package:wecount/shared/header.dart' show renderHeaderBack;
import 'package:wecount/shared/member_horizontal_list.dart';
import 'package:wecount/types/color.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/logger.dart';

import '../providers/current_ledger.dart';
import '../utils/colors.dart';
import '../utils/localization.dart';

enum LedgerEditMode {
  add,
  update,
}

class LedgerEdit extends StatefulWidget {
  static const String name = '/ledger_edit';

  final LedgerModel? ledger;
  final LedgerEditMode mode;

  const LedgerEdit({
    Key? key,
    this.ledger,
    this.mode = LedgerEditMode.add,
  }) : super(key: key);

  @override
  State<LedgerEdit> createState() => _LedgerEditState();
}

class _LedgerEditState extends State<LedgerEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late LedgerModel _ledger;
  final double _paddingHorizontal = 25;

  bool _isLoading = false;

  @override
  void initState() {
    _setLedger();
    super.initState();
  }

  void _setLedger() {
    if (widget.ledger == null) {
      _ledger = LedgerModel(
        title: '',
        currency: currencies[29],
        color: ColorType.dusk,
        adminIds: [],
        memberIds: [],
      );
      return;
    }

    _ledger = widget.ledger!;
  }

  void _onPressCurrency() async {
    var result = await General.instance.navigateScreen(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SettingCurrency(
          selectedCurrency: _ledger.currency.currency,
        ),
      ),
    );

    if (result != null) {
      setState(() => _ledger.currency = result);
    }
  }

  void _selectColor(ColorType item) {
    setState(() => _ledger.color = item);
  }

  Future<void> _pressDone() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      _ledger.description =
          _ledger.description == '' ? null : _ledger.description;

      try {
        if (widget.mode == LedgerEditMode.add) {
          await createNewLedger();
        } else if (widget.mode == LedgerEditMode.update) {
          final DatabaseService db = DatabaseService();
          await db.requestUpdateLedger(_ledger);
        }

        if (mounted) {
          Provider.of<CurrentLedger>(context, listen: false).ledger = _ledger;
        }

        Get.back();
      } catch (err) {
        logger.e('err: $err');
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> createNewLedger() async {
    final DatabaseService db = DatabaseService();
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      _ledger.ownerId = user.uid;
      _ledger.adminIds = [];
      _ledger.memberIds = [
        ..._ledger.memberIds,
        user.uid,
      ];

      await db.requestCreateNewLedger(_ledger);
    }
  }

  String? _validateFiled(String inputString) {
    if (inputString.isEmpty) {
      return Intl.message('EMPTY_WARNING');
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColor(_ledger.color),
      appBar: renderHeaderBack(
        iconColor: Colors.white,
        context: context,
        brightness: Brightness.dark,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () => Get.back(),
              child: Text(
                t('LEAVE'),
                semanticsLabel: t('LEAVE'),
                style: const TextStyle(
                  color: darkTransparent,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: _paddingHorizontal,
                  ),
                  child: TextFormField(
                    maxLines: 1,
                    maxLength: 20,
                    onChanged: (String txt) => _ledger.title = txt.trim(),
                    validator: (String? _) => _validateFiled(_ledger.title),
                    controller: TextEditingController(text: _ledger.title),
                    decoration: InputDecoration(
                      counterStyle: const TextStyle(
                        color: darkTransparent,
                      ),
                      hintMaxLines: 2,
                      border: InputBorder.none,
                      hintText: t('LEDGER_NAME_HINT'),
                      hintStyle: const TextStyle(
                        fontSize: 28.0,
                        color: darkTransparent,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _paddingHorizontal,
                  ),
                  child: TextFormField(
                    maxLines: 7,
                    maxLength: 300,
                    onChanged: (String txt) => _ledger.description = txt.trim(),
                    controller:
                        TextEditingController(text: _ledger.description),
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      counterStyle: const TextStyle(
                        color: darkTransparent,
                      ),
                      border: InputBorder.none,
                      hintText: t('LEDGER_DESCRIPTION_HINT'),
                      hintStyle: const TextStyle(
                        fontSize: 16.0,
                        color: darkTransparent,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                InkWell(
                  onTap: _onPressCurrency,
                  child: Container(
                    height: 80,
                    padding: EdgeInsets.symmetric(
                      horizontal: _paddingHorizontal,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          t('CURRENCY'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '${_ledger.currency.currency}'
                              ' | ${_ledger.currency.symbol}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              size: 16,
                              color: darkTransparent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: Colors.white70),
                Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(
                    horizontal: _paddingHorizontal,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        t('COLOR'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: colorItems.length,
                          itemExtent: 32,
                          itemBuilder: (context, index) {
                            final item =
                                colorItems[colorItems.length - index - 1];
                            bool selected = item == _ledger.color;

                            return ColorItem(
                              color: item,
                              onTap: () => _selectColor(item),
                              selected: selected,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white70),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: _paddingHorizontal,
                  ),
                  child: MemberHorizontalList(
                    backgroundColor: getColor(_ledger.color),
                    showAddBtn: true,
                    memberIds: _ledger.memberIds,
                    onSeeAllPressed: () => Get.to(
                      () => Members(
                        ledger: widget.ledger,
                      ),
                    ),
                    onMemberChanged: (List<String> memberIds) {
                      setState(() => _ledger.memberIds = memberIds);
                    },
                  ),
                ),
                const SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 100,
        child: ElevatedButton(
          onPressed: _pressDone,
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: _isLoading
              ? SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    semanticsLabel: t('LOADING'),
                    backgroundColor: Theme.of(context).primaryColor,
                    strokeWidth: 2,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  widget.ledger == null ? t('DONE') : t('UPDATE'),
                  style: TextStyle(
                    color: getColor(_ledger.color),
                    fontSize: 16.0,
                  ),
                ),
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
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ClipOval(
          child: Material(
            clipBehavior: Clip.hardEdge,
            color: getColor(color),
            child: InkWell(
              onTap: onTap,
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
            : const Empty()
      ],
    );
  }
}
