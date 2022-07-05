import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecount/models/ledger_model.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/screens/empty.dart';
import 'package:wecount/screens/profile_peer.dart';
import 'package:wecount/shared/edit_text.dart';
import 'package:wecount/shared/header.dart';
import 'package:wecount/shared/member_list_item.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/localization.dart';

class Members extends StatefulWidget {
  final LedgerModel? ledger;

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
      UserModel(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.owner,
      ),
    ),
    MemberItem(
      UserModel(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.admin,
      ),
    ),
    MemberItem(
      UserModel(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.admin,
      ),
    ),
    MemberItem(
      UserModel(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.guest,
      ),
    ),
    MemberItem(
      UserModel(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.guest,
      ),
    ),
    MemberItem(
      UserModel(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.guest,
      ),
    ),
    MemberItem(
      UserModel(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.guest,
      ),
    ),
    MemberItem(
      UserModel(
        displayName: 'displayName',
        email: 'email@email.com',
        thumbURL: 'url',
        membership: Membership.guest,
      ),
    ),
    MemberItem(
      UserModel(
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
            return Padding(
              padding: const EdgeInsets.all(20),
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MemberListItem(
                user: item.user,
                onPressAuth: () {
                  General.instance.showMembershipDialog(context, (int? val) {
                    setState(() {
                      item.user.changeMemberShip(val!);
                    });
                    Get.back();
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
              ),
            );
          }
          return const Empty();
        },
      ),
    );
  }
}
