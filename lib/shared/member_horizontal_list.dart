import 'package:bookoo2/utils/general.dart';
import 'package:bookoo2/utils/localization.dart';
import 'package:flutter/material.dart';

import 'package:bookoo2/utils/asset.dart' as Asset;


class MemberHorizontalList extends StatelessWidget {
  final bool showAddBtn;
  final Function onSeeAllPressed;
  MemberHorizontalList({
    this.showAddBtn,
    this.onSeeAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);
    return Container(
      height: 140,
      padding: EdgeInsets.only(left: 32.0, right: 20),
      margin: EdgeInsets.only(top: 24),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    _localization.trans('MEMBER'),
                    semanticsLabel: _localization.trans('MEMBER'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: this.onSeeAllPressed,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Text(
                      _localization.trans('SEE_ALL'),
                      semanticsLabel: _localization.trans('SEE_ALL'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 48,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                this.showAddBtn == true
                ? Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Material(
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: Container(
                      width: 48,
                      height: 48,
                      child: InkWell(
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).textTheme.display1.color,
                        ),
                        onTap: () {},
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.0,
                          color: Asset.Colors.cloudyBlue,
                        ),
                      ),
                    ),
                  ),
                )
                : Container(),
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Material(
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: Ink.image(
                      image: Asset.Icons.icMask,
                      fit: BoxFit.cover,
                      width: 48.0,
                      height: 48.0,
                      child: InkWell(
                        onTap: () {},
                      ),
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Material(
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: Ink.image(
                      image: Asset.Icons.icMask,
                      fit: BoxFit.cover,
                      width: 48.0,
                      height: 48.0,
                      child: InkWell(
                        onTap: () {},
                      ),
                    )
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}