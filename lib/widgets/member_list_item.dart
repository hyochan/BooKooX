import 'package:wecount/models/user_model.dart';
import 'package:wecount/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:wecount/utils/asset.dart' as Asset;

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
  @override
  final UserModel user;
  final Function? onPressMember;
  final Function? onPressAuth;

  const MemberListItem({
    super.key,
    required this.user,
    this.onPressMember,
    this.onPressAuth,
  });

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);

    return Container(
      height: 80,
      alignment: const Alignment(-1, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              onPressed: onPressMember as void Function()?,
              child: Row(
                children: <Widget>[
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      SizedBox(
                        width: 52,
                        height: 52,
                        child: Image(
                          image: Asset.Icons.icMask,
                          width: 40,
                          height: 40,
                        ),
                      ),
                      user.membership == Membership.Owner
                          ? Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image(
                                image: user.membership == Membership.Owner
                                    ? Asset.Icons.icOwner
                                    : Asset.Icons.icOwner,
                                width: 20,
                                height: 20,
                              ),
                            )
                          : const SizedBox(),
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
                            user.displayName,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
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
                                    .displayLarge!
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
          Container(
            alignment: const Alignment(0, 0),
            width: 80,
            height: double.infinity,
            child: TextButton(
              onPressed: onPressAuth as void Function()?,
              child: Text(
                user.membership == Membership.Owner
                    ? localization!.trans('MEMBER_OWNER')!
                    : user.membership == Membership.Admin
                        ? localization!.trans('MEMBER_ADMIN')!
                        : localization!.trans('MEMBER_GUEST')!,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.displayLarge!.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
