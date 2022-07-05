import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/screens/line_graph.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/general.dart' show General;

class HomeListItem extends StatelessWidget {
  final LedgerItemModel? ledgerItem;

  const HomeListItem({
    Key? key,
    this.ledgerItem,
  }) : super(key: key);

  List<Widget> buildLabelArea(
    String label, {
    UserModel? writer,
    required BuildContext context,
  }) {
    List<Widget> labelArea = [];
    labelArea.add(
      Text(
        label,
        style: TextStyle(
          color: Theme.of(context).textTheme.headline1!.color,
          fontSize: 16.0,
        ),
      ),
    );
    if (writer != null) {
      labelArea.add(
        Text(
          writer.displayName!,
          style: TextStyle(
            color: Theme.of(context).textTheme.headline2!.color,
            fontSize: 12.0,
          ),
        ),
      );
    }
    return labelArea;
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency();

    AssetImage image = ledgerItem!.category!.getIconImage()!;
    String label = ledgerItem!.category!.label!;
    UserModel? writer = ledgerItem!.writer;
    bool isPlus = ledgerItem!.price! > 0;
    String priceFormatted = formatCurrency.format(ledgerItem!.price ?? 0.0);
    String priceToShow =
        (isPlus ? '+ ' : '- ') + priceFormatted.toString().replaceAll('-', '');

    // ignore: deprecated_member_use
    return FlatButton(
      padding: const EdgeInsets.all(0),
      onPressed: () =>
          General.instance.navigateScreenNamed(context, LineGraph.name),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image(
                image: image,
                fit: BoxFit.contain,
                width: 30.0,
                height: 30.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildLabelArea(
                  label,
                  writer: writer,
                  context: context,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  priceToShow,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: isPlus
                        ? Theme.of(context).textTheme.headline1!.color
                        : carnationColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
