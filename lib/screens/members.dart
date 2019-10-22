import 'package:bookoo2/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bookoo2/models/Ledger.dart';
import 'package:bookoo2/shared/header.dart';
import 'package:bookoo2/utils/asset.dart' as Asset;

class Members extends StatefulWidget {
  final Ledger ledger;
  Members({Key key, this.ledger}) : super(key: key);

  @override
  _MembersState createState() => _MembersState(this.ledger);
}

class _MembersState extends State<Members> {
  Ledger _ledger;

  _MembersState(this._ledger);

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderClose(
        context: context,
        brightness: Brightness.light,
        actions: [
          Container(
            width: 56,
            child: RawMaterialButton(
              padding: EdgeInsets.all(0.0),
              shape: CircleBorder(),
              onPressed: () {},
              child: Icon(
                Icons.search,
                color: Theme.of(context).textTheme.title.color,
                semanticLabel: _localization.trans('SEARCH'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}