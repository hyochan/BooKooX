import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/screens/empty.dart';
import 'package:wecount/utils/asset.dart' as asset;

import '../utils/localization.dart';

abstract class ListItem {}

class HeadingItem implements ListItem {
  final int numOfPeople;

  HeadingItem({
    this.numOfPeople = 0,
  });
}

class MemberItem implements ListItem {
  final UserModel user;

  MemberItem(this.user);
}

class MemberListItem extends StatelessWidget {
  final UserModel user;
  final void Function()? onPressMember;
  final void Function()? onPressAuth;

  const MemberListItem({
    Key? key,
    required this.user,
    this.onPressMember,
    this.onPressAuth,
  }) : super(key: key);

  String _getMembership(Membership userMembership) {
    if (userMembership == Membership.owner) {
      return t('MEMBER_OWNER');
    }
    if (userMembership == Membership.admin) {
      return t('MEMBER_ADMIN');
    }

    return t('MEMBER_GUEST');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: onPressMember,
              child: Row(
                children: <Widget>[
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Image(
                        image: asset.Icons.icMask,
                        width: 52,
                        height: 52,
                      ),
                      user.membership == Membership.owner
                          ? Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image(
                                image: user.membership == Membership.owner
                                    ? asset.Icons.icOwner
                                    : asset.Icons.icOwner,
                                width: 20,
                                height: 20,
                              ),
                            )
                          : const Empty(),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AutoSizeText(
                            user.displayName!,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 18,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            child: AutoSizeText(
                              user.email!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          user.membership != null
              ? TextButton(
                  onPressed: onPressAuth,
                  child: Text(
                    _getMembership(user.membership!),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                  ),
                )
              : const Empty(),
        ],
      ),
    );
  }
}
