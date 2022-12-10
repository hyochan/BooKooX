import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/repositories/user_repository.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/logger.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';
import 'package:wecount/widgets/common/loading_indicator.dart';
import 'package:wecount/widgets/edit_text.dart';
import 'package:flutter/material.dart';

import 'package:wecount/screens/profile_peer.dart';
import 'package:wecount/widgets/member_list_item.dart';
import 'package:wecount/widgets/header.dart';
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
    var isSearchMode = useState<bool>(false);
    var filteredMembers = useState<List<ListItem>>([]);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: renderHeaderClose(
        context: context,
        brightness: Theme.of(context).brightness,
        actions: [
          SizedBox(
            width: 56,
            child: RawMaterialButton(
              padding: const EdgeInsets.all(0.0),
              shape: const CircleBorder(),
              onPressed: () => isSearchMode.value = !isSearchMode.value,
              child: Icon(
                Icons.search,
                color: Theme.of(context).textTheme.displayLarge!.color,
                semanticLabel: t('SEARCH'),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: UserRepository.instance.getMany(ledger?.id ?? ''),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return const LoadingIndicator();
              List<ListItem> members = [
                HeadingItem(
                  numOfPeople: snapshot.data.length,
                ),
                ...snapshot.data.map((e) => MemberItem(e!))
              ];
              return ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final item = members[index];
                  if (item is HeadingItem) {
                    return Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      alignment: const Alignment(-1, 0),
                      child: isSearchMode.value
                          ? EditText(
                              key: const Key('member'),
                              textInputAction: TextInputAction.next,
                              textHint: t('SEARCH_USER_HINT'),
                              onChanged: (String str) {
                                members = snapshot.data.where((list) {
                                  if (list is HeadingItem) {
                                    return true;
                                  } else if (list is MemberItem) {
                                    return list.user.email!
                                            .toLowerCase()
                                            .contains(str) ||
                                        list.user.displayName
                                            .toLowerCase()
                                            .contains(str);
                                  }
                                  return false;
                                }).toList();
                              },
                            )
                          : Text(
                              '${t('MEMBER')} ${item.numOfPeople}',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color,
                                fontSize: 28,
                              ),
                            ),
                    );
                  } else if (item is MemberItem) {
                    return MemberListItem(
                      user: item.user,
                      onPressAuth: () {
                        General.instance.showMembershipDialog(context,
                            (int? val) {
                          // item.user.changeMemberShip(val!);
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
                  return const SizedBox();
                },
              );
            }),
      ),
    );
  }
}
