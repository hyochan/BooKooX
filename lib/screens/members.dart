import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:bookoo2/screens/profile_peer.dart';
import 'package:bookoo2/utils/general.dart';
import 'package:bookoo2/shared/member_list_item.dart';
import 'package:bookoo2/shared/header.dart';
import 'package:bookoo2/shared/member_list_item.dart' show MemberItem, HeadingItem, ListItem;
import 'package:bookoo2/models/User.dart' show User;
import 'package:bookoo2/models/User.dart';
import 'package:bookoo2/models/Ledger.dart';
import 'package:bookoo2/utils/localization.dart';

class Members extends StatefulWidget {
  final Ledger ledger;
  Members({Key key, this.ledger}) : super(key: key);

  @override
  _MembersState createState() => _MembersState(this.ledger);
}

class _MembersState extends State<Members> {
  Ledger _ledger;
  _MembersState(this._ledger);

  final List<ListItem> _fakeMembers = [
    HeadingItem(
      numOfPeople: 4,
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.Owner,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.Admin,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.Admin,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.Guest,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.Guest,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.Guest,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.Guest,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.Guest,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.Guest,
      ),
    ),
  ];

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
      body: ListView.builder(
        itemCount: _fakeMembers.length,
        itemBuilder: (context, index) {
          final item = _fakeMembers[index];
          if (item is HeadingItem) {
            return Container(
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 40),
              alignment: Alignment(-1, 0),
              child: Text(
                '${_localization.trans('MEMBER')} ${item.numOfPeople}',
                style: TextStyle(
                  color: Theme.of(context).textTheme.title.color,
                  fontSize: 28,
                ),
              ),
            );
          } else if (item is MemberItem) {
            return MemberListItem(
              user: item.user,
              onPressAuth: () {
                General.instance.showMembershipDialog(context, (int val) {
                  setState(() {
                    item.user.changeMemberShip(val);
                  });
                  Navigator.of(context).pop();
                }, item.user.membership.index);
              },
              onPressMember: () {
                General.instance.navigateScreen(context, MaterialPageRoute(
                  builder: (BuildContext context) => ProfilePeer(
                    user: item.user,
                  ),
                ));
              },
            );
          }
          return null;
        },
      ),
    );
  }
}