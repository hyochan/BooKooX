import 'package:bookoo2/models/LedgerItem.dart';
import 'package:flutter/material.dart';

class HomeListItem extends StatelessWidget {
  HomeListItem(LedgerItem ledgerItem) {
    // this.ledgerItem = ledgerItem;
    this._image = ledgerItem.category.getIconImage();
    this._label = ledgerItem.category.label;
    this._isPlus = ledgerItem.cost > 0;
    this._cost = (_isPlus ? '+ ' : '- ') + ledgerItem.cost.toString().replaceAll('-', '') + ' 원';
  }

  LedgerItem ledgerItem;
  AssetImage _image;
  String _label;
  String _cost;
  bool _isPlus;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      // color: Colors.amber[700],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image(
              // image: Asset.Icons.icRed,
              image: _image,
              fit: BoxFit.contain,
              width: 30.0,
              height: 30.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            // child: Text('운동'),
            child: Text(_label),
          ),
          Expanded(
            child: Container(
              // color: Colors.blueAccent,
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
