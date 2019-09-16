import 'package:bookoo2/models/LedgerItem.dart';
import 'package:flutter/material.dart';

class HomeListItem extends StatelessWidget {
  final LedgerItem ledgerItem;

  HomeListItem({Key key, this.ledgerItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetImage _image = ledgerItem.category.getIconImage();
    String _label = ledgerItem.category.label;
    bool _isPlus = ledgerItem.cost > 0;
    String _cost = (_isPlus ? '+ ' : '- ') +
        ledgerItem.cost.toString().replaceAll('-', '') +
        ' 원';

    return Container(
      height: 60,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image(
              image: _image,
              fit: BoxFit.contain,
              width: 30.0,
              height: 30.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(_label),
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  _cost,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: _isPlus
                          ? Theme.of(context).primaryColor
                          : Colors.grey[600]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
