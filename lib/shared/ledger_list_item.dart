import 'package:flutter/material.dart';

import 'package:bookoox/models/Ledger.dart';
import 'package:bookoox/utils/asset.dart' as Asset;
import 'package:bookoox/utils/localization.dart' show Localization;
import 'package:bookoox/types/color.dart' show ColorType;

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String displayName;
  final String email;
  final String imageString;

  HeadingItem(this.displayName, this.email, this.imageString);
}

class LedgerItem implements ListItem {
  final Ledger ledger;
  final bool isOwner;

  LedgerItem(this.ledger, this.isOwner);
}

class LedgerListItem extends StatelessWidget {
  const LedgerListItem({
    this.key,
    this.title,
    this.color,
    this.people,
    this.isOwner,
    this.onMorePressed,
  });

  final Key key;
  final String title;
  final ColorType color;
  final int people;
  final bool isOwner;
  final Function onMorePressed;

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);
    return Container(
      height: 100.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              child: MaterialButton(
                padding: EdgeInsets.only(left: 24.0),
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 48.0,
                      height: 48.0,
                      child: Stack(
                        children: <Widget>[
                          ClipOval(
                            child: Image(
                              image: color == ColorType.RED
                                ? Asset.Icons.icRed
                                : color == ColorType.ORANGE
                                ? Asset.Icons.icOrange
                                : color == ColorType.YELLOW
                                ? Asset.Icons.icYellow
                                : color == ColorType.GREEN
                                ? Asset.Icons.icGreen
                                : color == ColorType.BLUE
                                ? Asset.Icons.icBlue
                                : color == ColorType.PURPLE
                                ? Asset.Icons.icPurple
                                : Asset.Icons.icDusk
                              ,
                              fit: BoxFit.cover,
                              width: 40.0,
                              height: 40.0,
                            ),
                          ),
                          isOwner
                          ? Positioned(
                            right: 4,
                            bottom: 4,
                            child: Image(
                              image: Asset.Icons.icOwner,
                              width: 20,
                              height: 20,
                            ),
                          )
                          : Container(),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              title,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.title.color,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        Container(
                            child: Text(
                              people > 1
                              ? '$people ${_localization.trans("PEOPLE")}'
                              : '$people ${_localization.trans("PERSON")}',
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          FlatButton(
            onPressed: onMorePressed,
            padding: EdgeInsets.all(0),
            child: Container(
              height: double.infinity,
              child: Center(
                child: Text(
                  _localization.trans('MORE'),
                  style: TextStyle(
                    color: Asset.Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
