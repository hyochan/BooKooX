import 'package:wecount/models/User.dart';
import 'package:wecount/services/database.dart';
import 'package:wecount/utils/localization.dart';
import 'package:flutter/material.dart';

import 'package:wecount/utils/asset.dart' as Asset;

class MemberHorizontalList extends StatelessWidget {
  final bool showAddBtn;
  final Function onSeeAllPressed;
  final List<String> memberIds;
  MemberHorizontalList({
    this.showAddBtn,
    this.onSeeAllPressed,
    this.memberIds = const [],
  });

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);

    List<Widget> memberWidgets = memberIds.map((memberId) {
      return StreamBuilder(
        stream: DatabaseService().streamUser(memberId),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          return Container(
            margin: EdgeInsets.only(left: 8),
            child: Material(
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Ink.image(
                  image: !snapshot.hasData ||
                          (snapshot.data.photoURL == null &&
                              snapshot.data.thumbURL == null)
                      ? Asset.Icons.icMask
                      : NetworkImage(snapshot.data.thumbURL != null
                          ? snapshot.data.thumbURL
                          : snapshot.data.photoURL),
                  fit: BoxFit.cover,
                  width: 48.0,
                  height: 48.0,
                  child: InkWell(
                    onTap: () {},
                  ),
                )),
          );
        },
      );
    }).toList();

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
                                color: Colors.white,
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
                Row(
                  children: memberWidgets,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
