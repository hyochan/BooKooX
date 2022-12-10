import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';
import 'package:wecount/widgets/edit_text.dart';
import 'package:flutter/material.dart';

import 'package:wecount/screens/profile_peer.dart';
import 'package:wecount/widgets/member_list_item.dart';
import 'package:wecount/widgets/header.dart';
import 'package:wecount/models/user.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/utils/localization.dart';

class MembersArguments {
  final Ledger? ledger;

  MembersArguments({this.ledger});
}

class Members extends HookWidget {
  final Ledger? ledger;
  const Members({Key? key, this.ledger}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _isSearchMode = useState<bool>(false);
    var _filteredMembers = useState<List<ListItem>>([]);

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

    useEffect(() {
      _filteredMembers.value = _fakeMembers;
      return null;
    }, []);
    var _localization = Localization.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                _isSearchMode.value = !_isSearchMode.value;
                if (!_isSearchMode.value) {
                  _filteredMembers.value = _fakeMembers;
                }
              },
              child: Icon(
                Icons.search,
                color: Theme.of(context).textTheme.displayLarge!.color,
                semanticLabel: _localization.trans('SEARCH'),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _filteredMembers.value.length,
        itemBuilder: (context, index) {
          final item = _filteredMembers.value[index];
          if (item is HeadingItem) {
            return Container(
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 40),
              alignment: Alignment(-1, 0),
              child: _isSearchMode.value
                  ? EditText(
                      key: Key('member'),
                      textInputAction: TextInputAction.next,
                      textHint: _localization.trans('SEARCH_USER_HINT'),
                      onChanged: (String str) {
                        _filteredMembers.value = _fakeMembers.where((list) {
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
                      },
                    )
                  : Text(
                      '${_localization.trans('MEMBER')} ${item.numOfPeople}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displayLarge!.color,
                        fontSize: 28,
                      ),
                    ),
            );
          } else if (item is MemberItem) {
            return MemberListItem(
              user: item.user,
              onPressAuth: () {
                navigation.showMembershipDialog(context, (int? val) {
                  item.user.changeMemberShip(val!);
                  Navigator.of(context).pop();
                }, item.user.membership!.index);
              },
              onPressMember: () {
                navigation.navigate(context, AppRoute.profilePeer.path,
                    arguments: ProfilePeerArguments(
                      user: item.user,
                    ));
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
