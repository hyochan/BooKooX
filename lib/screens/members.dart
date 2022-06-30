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
  const Members({
    Key? key,
    this.ledger,
  }) : super(key: key);

  @override
  State<Members> createState() => _MembersState();
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
        membership: Membership.owner,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.admin,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.admin,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.guest,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.guest,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.guest,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.guest,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.guest,
      ),
    ),
    MemberItem(
      User(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.guest,
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
      appBar: renderHeaderClose(
        context: context,
        actions: [
          SizedBox(
            width: 56,
            child: InkWell(
              onTap: () {
                setState(() {
                  _isSearchMode = !_isSearchMode;

                  if (!_isSearchMode) {
                    _filteredMembers = _fakeMembers;
                  }
                });
              },
              child: Icon(
                Icons.search,
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
              padding: const EdgeInsets.symmetric(horizontal: 40),
              alignment: const Alignment(-1, 0),
              child: _isSearchMode
                  ? EditText(
                      key: const Key('member'),
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
