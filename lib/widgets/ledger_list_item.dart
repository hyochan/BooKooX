import 'package:flutter/material.dart';
import '../utils/asset.dart' as Asset;
import '../utils/localization.dart' show Localization;
import '../types/color.dart' show ColorType;

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
                                : Asset.Icons.icGreen
                              ,
                              fit: BoxFit.cover,
                              width: 40.0,
                              height: 40.0,
                            ),
                          ),
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
                                color: Theme.of(context).primaryColor,
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
          Container(
            child: FlatButton(
              onPressed: onMorePressed,
              child: Text(
                _localization.trans('MORE'),
                style: TextStyle(
                  color: Asset.Colors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
