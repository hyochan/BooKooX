import 'package:flutter/material.dart';
import 'package:bookoox/screens/setting_currency.dart';
import 'package:bookoox/screens/members.dart';
import 'package:bookoox/shared/member_horizontal_list.dart';
import 'package:bookoox/shared/header.dart' show renderHeaderBack;
import 'package:bookoox/utils/general.dart';
import 'package:bookoox/utils/localization.dart';
import 'package:bookoox/utils/asset.dart' as Asset;
import 'package:bookoox/models/Currency.dart';
import 'package:bookoox/models/Ledger.dart';
import 'package:bookoox/types/color.dart';

class LedgerEdit extends StatefulWidget {
  final Ledger ledger;
  LedgerEdit({Key key, this.ledger}) : super(key: key);

  @override
  _LedgerEditState createState() => new _LedgerEditState();
}

class _LedgerEditState extends State<LedgerEdit> {
  Ledger _ledger = Ledger(
    title: '',
    currency: currencies[29],
    color: ColorType.DUSK,
  );

  void _onPressCurrency() async {
    var _result = await General.instance.navigateScreen(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => SettingCurrency(
                selectedCurrency: _ledger.currency.currency,
              )),
    );

    if (_result == null) return;

    setState(() => _ledger.currency = _result);
  }

  void _onSelectColor(ColorType item) {
    setState(() => _ledger.color = item);
  }

  void _onDonePressed() {
    print('done\n ${_ledger.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);

    return Scaffold(
      backgroundColor: Asset.Colors.getColor(_ledger.color),
      appBar: renderHeaderBack(
        context: context,
        brightness: Theme.of(context).brightness,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 40, left: 40, right: 40),
              child: TextField(
                maxLines: 2,
                onChanged: (String txt) {
                  _ledger.title = txt;
                },
                controller: TextEditingController(text: _ledger.title),
                decoration: InputDecoration(
                  hintMaxLines: 2,
                  border: InputBorder.none,
                  hintText: _localization.trans('LEDGER_NAME_HINT'),
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
              margin: EdgeInsets.only(top: 24, left: 40, right: 40, bottom: 20),
              height: 160,
              child: TextField(
                maxLines: 8,
                onChanged: (String txt) {
                  _ledger.description = txt;
                },
                controller: TextEditingController(text: _ledger.description),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: _localization.trans('LEDGER_DESCRIPTION_HINT'),
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(255, 255, 255, 0.7),
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
                      _localization.trans('CURRENCY'),
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
                            color: Color.fromRGBO(255, 255, 255, 0.7),
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
                      _localization.trans('COLOR'),
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
                          final item = colorItems[index];
                          bool selected = item == _ledger.color;
                          return ColorItem(
                            color: item,
                            onTap: () => _onSelectColor(item),
                            selected: selected,
                          );
                        },
                      ),
                    ),
                  ),
                  // MemberHorizontalList(
                  //   showAddBtn: true,
                  //   onSeeAllPressed: () => General.instance.navigateScreen(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             Members(ledger: widget.ledger)),
                  //   ),
                  // ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: widget.ledger != null
                      ? EdgeInsets.only(right: 20, top: 0, bottom: 20)
                      : EdgeInsets.only(right: 20, top: 46, bottom: 20),
                  child: SizedBox(
                    child: FlatButton(
                      padding: EdgeInsets.all(20),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.0),
                      ),
                      onPressed: _onDonePressed,
                      child: Text(
                        widget.ledger == null
                            ? _localization.trans('DONE')
                            : _localization.trans('UPDATE'),
                        style: TextStyle(
                          color: Asset.Colors.getColor(_ledger.color),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ColorItem extends StatelessWidget {
  ColorItem({
    Key key,
    this.color,
    this.selected,
    this.onTap,
  }) : super(key: key);
  final ColorType color;
  final bool selected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ClipOval(
          child: Material(
            clipBehavior: Clip.hardEdge,
            color: Asset.Colors.getColor(color),
            child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.white),
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
            : Container()
      ],
    );
  }
}
