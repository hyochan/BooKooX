import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:wecount/widgets/member_horizontal_list.dart';
import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/models/currency.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/utils/localization.dart';
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/widgets/colors.dart';

class LedgerViewArguments {
  final Ledger? ledger;

  LedgerViewArguments({this.ledger});
}

class LedgerView extends HookWidget {
  const LedgerView({
    super.key,
    this.ledger,
  });
  final Ledger? ledger;

  @override
  Widget build(BuildContext context) {
    var viewLedger = useState<Ledger?>(null);

    useEffect(() {
      if (ledger != null) {
        viewLedger.value = ledger;
        return;
      }
      viewLedger.value = Ledger(
        title: 'ledger test',
        currency: Currency(currency: '￦', locale: 'KRW'),
        color: ColorType.dusk,
      );
      return null;
    }, []);

    return Scaffold(
      backgroundColor: asset.Colors.getColor(viewLedger.value!.color),
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
                  viewLedger.value = viewLedger.value!.copyWith(title: txt);
                },
                controller:
                    TextEditingController(text: viewLedger.value!.title),
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
                enabled: false,
                maxLines: 8,
                controller:
                    TextEditingController(text: viewLedger.value!.description),
                onChanged: (String txt) {
                  viewLedger.value =
                      viewLedger.value!.copyWith(description: txt);
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
              onPressed: null,
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
                          '${viewLedger.value!.currency.locale} | ${viewLedger.value!.currency.currency}',
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
                          final item = colorItems[index];
                          bool selected = item == viewLedger.value!.color;
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
            const MemberHorizontalList(),
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
            : Container()
      ],
    );
  }
}
