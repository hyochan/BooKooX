import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wecount/models/user.dart';
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
  final User user;

  MemberItem(this.user);
}

class MemberListItem extends StatelessWidget {
  final User user;
  final Function? onPressMember;
  final Function? onPressAuth;

  const MemberListItem({
    Key? key,
    required this.user,
    this.onPressMember,
    this.onPressAuth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      alignment: const Alignment(-1, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            // ignore: deprecated_member_use
            child: FlatButton(
              onPressed: onPressMember as void Function()?,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: <Widget>[
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      SizedBox(
                        width: 52,
                        height: 52,
                        child: Image(
                          image: asset.Icons.icMask,
                          width: 40,
                          height: 40,
                        ),
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
                          : Container(),
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
          Container(
            alignment: const Alignment(0, 0),
            width: 80,
            height: double.infinity,
            // ignore: deprecated_member_use
            child: FlatButton(
              padding: const EdgeInsets.all(0),
              onPressed: onPressAuth as void Function()?,
              child: Text(
                user.membership == Membership.owner
                    ? t('MEMBER_OWNER')
                    : user.membership == Membership.admin
                        ? t('MEMBER_ADMIN')
                        : t('MEMBER_GUEST'),
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
