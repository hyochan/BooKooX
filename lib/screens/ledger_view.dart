import 'package:flutter/material.dart';
import 'package:wecount/models/currency_model.dart';
import 'package:wecount/models/ledger_model.dart';
import 'package:wecount/shared/header.dart' show renderHeaderBack;
import 'package:wecount/shared/member_horizontal_list.dart';
import 'package:wecount/types/color.dart';
import 'package:wecount/utils/localization.dart';

import '../utils/colors.dart';

class LedgerView extends StatefulWidget {
  static const String name = '/ledger_view';

  final LedgerModel? ledger;

  const LedgerView({
    Key? key,
    this.ledger,
  }) : super(key: key);

  @override
  State<LedgerView> createState() => _LedgerViewState();
}

class _LedgerViewState extends State<LedgerView> {
  late LedgerModel _ledger;

  @override
  initState() {
    _ledger = _setLedger();
    super.initState();
  }

  _setLedger() {
    if (widget.ledger != null) {
      return widget.ledger!;
    }

    return LedgerModel(
      title: 'ledger test',
      currency: CurrencyModel(currency: '￦', locale: 'KRW'),
      color: ColorType.dusk,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColor(_ledger.color),
      appBar: renderHeaderBack(
        context: context,
        iconColor: Colors.white,
        brightness: Theme.of(context).brightness,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 40, left: 40, right: 40),
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
                  hintText: t('LEDGER_NAME_HINT'),
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
                enabled: false,
                maxLines: 8,
                controller: TextEditingController(text: _ledger.description),
                onChanged: (String txt) {
                  _ledger.description = txt;
                },
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: t('LEDGER_DESCRIPTION_HINT'),
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
              onPressed: null,
              child: Container(
                height: 80.0,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 40.0, right: 28.0),
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
                          '${_ledger.currency.locale} | ${_ledger.currency.currency}',
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
                    t('COLOR'),
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
            const Divider(color: Colors.white70),
            MemberHorizontalList(
              backgroundColor: getColor(_ledger.color),
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
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              )
            : Container()
      ],
    );
  }
}
