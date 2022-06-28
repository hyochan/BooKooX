import 'package:wecount/shared/edit_text.dart';
import 'package:flutter/material.dart';

import 'package:wecount/screens/profile_peer.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/shared/member_list_item.dart';
import 'package:wecount/shared/header.dart';
import 'package:wecount/models/user.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/utils/localization.dart';

class Members extends StatefulWidget {
  final Ledger? ledger;
  Members({
    Key? key,
    this.ledger,
  }) : super(key: key);

  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  bool _isSearchMode = false;
  List<ListItem> _filteredMembers = [];

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
  void initState() {
    super.initState();
    _filteredMembers = _fakeMembers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderClose(
        context: context,
        brightness: Theme.of(context).brightness,
        actions: [
          Container(
            width: 56,
            child: RawMaterialButton(
              padding: EdgeInsets.all(0.0),
              shape: CircleBorder(),
              onPressed: () {
                setState(() {
                  _isSearchMode = !_isSearchMode;
                  if (!_isSearchMode) {
                    _filteredMembers = _fakeMembers;
                  }
                });
              },
              child: Icon(
                Icons.search,
                color: Theme.of(context).textTheme.headline1!.color,
                semanticLabel: t('SEARCH'),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _filteredMembers.length,
        itemBuilder: (context, index) {
          final item = _filteredMembers[index];
          if (item is HeadingItem) {
            return Container(
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 40),
              alignment: Alignment(-1, 0),
              child: _isSearchMode
                  ? EditText(
                      key: Key('member'),
                      textInputAction: TextInputAction.next,
                      textHint: t('SEARCH_USER_HINT'),
                      onChanged: (String str) {
                        setState(() {
                          _filteredMembers = _fakeMembers.where((list) {
                            if (list is HeadingItem) {
                              return true;
                            } else if (list is MemberItem) {
                              return list.user.email!
                                      .toLowerCase()
                                      .contains(str) ||
                                  list.user.displayName!
                                      .toLowerCase()
                                      .contains(str);
                            }
                            return false;
                          }).toList();
                        });
                      },
                    )
                  : Text(
                      '${t('MEMBER')} ${item.numOfPeople}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline1!.color,
                        fontSize: 28,
                      ),
                    ),
            );
          } else if (item is MemberItem) {
            return MemberListItem(
              user: item.user,
              onPressAuth: () {
                General.instance.showMembershipDialog(context, (int? val) {
                  setState(() {
                    item.user.changeMemberShip(val!);
                  });
                  Navigator.of(context).pop();
                }, item.user.membership!.index);
              },
              onPressMember: () {
                General.instance.navigateScreen(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProfilePeer(
                      user: item.user,
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
