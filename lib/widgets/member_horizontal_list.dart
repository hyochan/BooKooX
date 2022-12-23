import 'package:wecount/models/user_model.dart';
import 'package:wecount/repositories/user_repository.dart';
import 'package:wecount/services/database.dart';
import 'package:flutter/material.dart';

import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/localization.dart';
import 'package:wecount/utils/logger.dart';

class MemberHorizontalList extends StatelessWidget {
  final bool? showAddBtn;
  final Function? onSeeAllPressed;
  final List<String> memberIds;
  const MemberHorizontalList({
    super.key,
    this.showAddBtn,
    this.onSeeAllPressed,
    this.memberIds = const [],
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> memberWidgets = memberIds.map((memberId) {
      return FutureBuilder(
        future: UserRepository.instance.getOne(memberId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            margin: const EdgeInsets.only(left: 8),
            child: Material(
              shape: const CircleBorder(),
              clipBehavior: Clip.hardEdge,
              color: Colors.transparent,
              child: Ink.image(
                image: (!snapshot.hasData ||
                        (snapshot.data!.photoURL == null &&
                            snapshot.data!.thumbURL == null)
                    ? asset.AppIcons.icMask
                    : NetworkImage(snapshot.data!.thumbURL != null
                        ? snapshot.data!.thumbURL!
                        : snapshot.data!.photoURL!)) as ImageProvider<Object>,
                fit: BoxFit.cover,
                width: 48.0,
                height: 48.0,
                child: InkWell(
                  onTap: () {
                    logger.d('profile click');
                  },
                ),
              ),
            ),
          );
        },
      );
    }).toList();

    return Container(
      height: 140,
      padding: const EdgeInsets.only(left: 32.0, right: 20),
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  localization(context).member,
                  semanticsLabel: localization(context).member,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: onSeeAllPressed as void Function()?,
                  child: Text(
                    localization(context).seeAll,
                    semanticsLabel: localization(context).seeAll,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 48,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                showAddBtn == true
                    ? Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: Material(
                          shape: const CircleBorder(),
                          clipBehavior: Clip.hardEdge,
                          color: Colors.transparent,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1.0,
                                color: AppColors.role.info,
                              ),
                            ),
                            child: InkWell(
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onTap: () {
                                logger.d('add member');
                              },
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                Row(
                  children: memberWidgets,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
