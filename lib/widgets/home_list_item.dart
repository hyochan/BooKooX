import 'package:wecount/models/ledger_item.dart';
import 'package:flutter/material.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/screens/line_graph.dart';
import 'package:wecount/utils/asset.dart' as Asset;
import 'package:intl/intl.dart';
import 'package:wecount/utils/logger.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

class HomeListItem extends StatelessWidget {
  final LedgerItem? ledgerItem;

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
          color: Theme.of(context).textTheme.displayLarge!.color,
          fontSize: 16.0,
        ),
      ),
    );

    if (writer != null) {
      labelArea.add(
        Text(
          writer.displayName,
          style: TextStyle(
            color: Theme.of(context).textTheme.displayMedium!.color,
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
    String label = ledgerItem!.category!.label;
    UserModel? writer = ledgerItem!.writer;
    bool isPlus = ledgerItem!.price! > 0;
    String priceFormatted = formatCurrency.format(ledgerItem!.price ?? 0.0);
    String priceToShow =
        (isPlus ? '+ ' : '- ') + priceFormatted.toString().replaceAll('-', '');

    return TextButton(
      onPressed: () => navigation.push(context, AppRoute.lineGraph.path,
          arguments: LineGraphArguments(label, '2022', ledgerItem!.price)),
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
                          ? Theme.of(context).textTheme.displayLarge!.color
                          : Asset.Colors.carnation),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
