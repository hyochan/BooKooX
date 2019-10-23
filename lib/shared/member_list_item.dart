import 'package:bookoo2/models/User.dart';
import 'package:flutter/material.dart';
import 'package:bookoo2/utils/asset.dart' as Asset;

abstract class ListItem {}

class HeadingItem implements ListItem {
  final int numOfPeople;

  HeadingItem({
    this.numOfPeople = 0,
  });
}

class MemberItem implements ListItem {
  final User user;
  final Membership membership;

  MemberItem(this.user, this.membership);
}

class MemberListItem extends StatelessWidget {
  final Key key;
  final User user;
  final Membership membership;

  const MemberListItem({
    this.key,
    @required this.user,
    @required this.membership,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 40),
      alignment: Alignment(-1, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              onPressed: () {},
              padding: EdgeInsets.all(0),
              child: Row(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: 52,
                        height: 52,
                        child: Image(
                          image: Asset.Icons.icMask,
                          width: 40,
                          height: 40,
                        ),
                      ),
                      membership == Membership.Owner
                      ? Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image(
                          image: membership == Membership.Owner
                            ? Asset.Icons.icOwner
                            : Asset.Icons.icOwner,
                          width: 20,
                          height: 20,
                        ),
                      ) : Container(),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).textTheme.title.color,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            user.email,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).textTheme.display2.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment(0,0),
            width: 60,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Text(
                membership == Membership.Owner
                ? 'Owner'
                : membership == Membership.Writer
                ? 'Writer'
                : 'Guest',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.display2.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}