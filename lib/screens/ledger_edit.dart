import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecount/models/currency.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/screens/empty.dart';
import 'package:wecount/screens/members.dart';
import 'package:wecount/screens/setting_currency.dart';
import 'package:wecount/services/database.dart' show DatabaseService;
import 'package:wecount/shared/header.dart' show renderHeaderBack;
import 'package:wecount/shared/member_horizontal_list.dart';
import 'package:wecount/types/color.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/logger.dart';

import '../utils/colors.dart';
import '../utils/localization.dart';

enum LedgerEditMode {
  ADD,
  UPDATE,
}

class LedgerEdit extends StatefulWidget {
  static const String name = '/ledger_edit';

  final Ledger? ledger;
  final LedgerEditMode mode;

  LedgerEdit({
    Key? key,
    this.ledger,
    this.mode = LedgerEditMode.ADD,
  }) : super(key: key);

  @override
  _LedgerEditState createState() => _LedgerEditState();
}

class _LedgerEditState extends State<LedgerEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Ledger _ledger;

  bool _isLoading = false;

  @override
  void initState() {
    _setLedger();
    super.initState();
  }

  void _setLedger() {
    if (widget.ledger == null) {
      _ledger = Ledger(
        title: '',
        currency: currencies[29],
        color: ColorType.DUSK,
        adminIds: [],
        memberIds: [],
      );
    } else {
      _ledger = widget.ledger!;
    }
  }

  void _onPressCurrency() async {
    var _result = await General.instance.navigateScreen(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SettingCurrency(
          selectedCurrency: _ledger.currency.currency,
        ),
      ),
    );

    if (_result != null) {
      setState(() => _ledger.currency = _result);
    }
  }

  void _selectColor(ColorType item) {
    setState(() => _ledger.color = item);
  }

  Future<void> _pressDone() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final DatabaseService db = DatabaseService();

        if (widget.mode == LedgerEditMode.ADD) {
          await db.requestCreateNewLedger(_ledger);
        } else if (widget.mode == LedgerEditMode.UPDATE) {
          await db.requestUpdateLedger(_ledger);
        }
      } catch (err) {
        logger.e('err: $err');
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _leaveLedger() async {
    bool hasLeft = await DatabaseService().requestLeaveLedger(_ledger.id);

    if (hasLeft) {
      Ledger? ledger = await DatabaseService().fetchSelectedLedger();
      Provider.of<CurrentLedger>(context, listen: false).setLedger(ledger);

      Get.back();
    }

    General.instance.showSingleDialog(
      context,
      title: Text(t('ERROR')),
      content: Text(t('SHOULD_TRANSFER_OWNERSHIP')),
    );
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
        context: context,
        brightness: Brightness.dark,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: _leaveLedger,
              child: Text(
                t('LEAVE'),
                semanticsLabel: t('LEAVE'),
                style: TextStyle(
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
          child: Stack(
            children: [
              ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                    child: TextFormField(
                      maxLines: 1,
                      onChanged: (String txt) {
                        _ledger.title = txt.trim();
                      },
                      validator: (String? _) => _validateFiled(_ledger.title),
                      controller: TextEditingController(text: _ledger.title),
                      decoration: InputDecoration(
                        hintMaxLines: 2,
                        border: InputBorder.none,
                        hintText: t('LEDGER_NAME_HINT'),
                        hintStyle: TextStyle(
                          fontSize: 28.0,
                          color: Color.fromRGBO(255, 255, 255, 0.7),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 28.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 24, left: 40, right: 40, bottom: 20),
                    height: 160,
                    child: TextFormField(
                      maxLines: 8,
                      onChanged: (String txt) {
                        _ledger.description = txt.trim();
                      },
                      controller:
                          TextEditingController(text: _ledger.description),
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: t('LEDGER_DESCRIPTION_HINT'),
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          color: darkTransparent,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: _onPressCurrency,
                    child: Container(
                      height: 80.0,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 40.0, right: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            t('CURRENCY'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '${_ledger.currency.currency} | ${_ledger.currency.symbol}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.chevron_right,
                                  size: 16,
                                  color: darkTransparent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.white70),
                  Container(
                    height: 80.0,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            t('COLOR'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: 32),
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
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.white70),
                  MemberHorizontalList(
                    showAddBtn: true,
                    memberIds:
                        widget.ledger != null ? widget.ledger!.memberIds : [],
                    onSeeAllPressed: () => Get.to(
                      () => Members(
                        ledger: widget.ledger,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 24,
                right: 24,
                child: SizedBox(
                  height: 60,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: _pressDone,
                    child: _isLoading
                        ? Container(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              semanticsLabel: t('LOADING'),
                              backgroundColor: Theme.of(context).primaryColor,
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            widget.ledger == null ? t('DONE') : t('UPDATE'),
                            style: TextStyle(
                              color: getColor(_ledger.color),
                              fontSize: 16.0,
                            ),
                          ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorItem extends StatelessWidget {
  ColorItem({
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
            color: getColor(color),
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
            ? Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              )
            : const Empty()
      ],
    );
  }
}
