import 'package:flutter/material.dart';

import 'package:wecount/shared/member_horizontal_list.dart';
import 'package:wecount/shared/header.dart' show renderHeaderBack;
import 'package:wecount/models/currency.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/utils/localization.dart';
import 'package:wecount/utils/asset.dart' as Asset;
import 'package:wecount/types/color.dart';

class LedgerView extends StatefulWidget {
  static const String name = '/ledger_view';

  final Ledger? ledger;
  const LedgerView({
    Key? key,
    this.ledger,
  }) : super(key: key);

  @override
  _LedgerViewState createState() => new _LedgerViewState(ledger);
}

class _LedgerViewState extends State<LedgerView> {
  late Ledger _ledger;

  _LedgerViewState(Ledger? ledger) {
    if (ledger != null) {
      _ledger = ledger;
      return;
    }
    _ledger = Ledger(
      title: 'ledger test',
      currency: Currency(currency: '\￦', locale: 'KRW'),
      color: ColorType.DUSK,
    );
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context)!;

    return Scaffold(
      backgroundColor: Asset.Colors.getColor(_ledger.color),
      appBar: renderHeaderBack(
        context: context,
        iconColor: Colors.white,
        brightness: Theme.of(context).brightness,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 40, left: 40, right: 40),
              child: TextField(
                enabled: false,
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
                enabled: false,
                maxLines: 8,
                controller: TextEditingController(text: _ledger.description),
                onChanged: (String txt) {
                  _ledger.description = txt;
                },
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
              onPressed: null,
              child: Container(
                height: 80.0,
                width: double.infinity,
                padding: EdgeInsets.only(left: 40.0, right: 28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _localization.trans('CURRENCY')!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '${_ledger.currency.locale} | ${_ledger.currency.currency}',
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
                      _localization.trans('COLOR')!,
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
            MemberHorizontalList(),
          ],
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
            color: Asset.Colors.getColor(color),
            child: InkWell(
              onTap: onTap as void Function()?,
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
