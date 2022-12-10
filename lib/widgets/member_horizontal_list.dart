import 'package:wecount/models/user_model.dart';
import 'package:wecount/repositories/user_repository.dart';
import 'package:wecount/services/database.dart';
import 'package:wecount/utils/localization.dart';
import 'package:flutter/material.dart';

import 'package:wecount/utils/asset.dart' as Asset;

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
    var localization = Localization.of(context)!;

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
                    ? Asset.Icons.icMask
                    : NetworkImage(snapshot.data!.thumbURL != null
                        ? snapshot.data!.thumbURL!
                        : snapshot.data!.photoURL!)) as ImageProvider<Object>,
                fit: BoxFit.cover,
                width: 48.0,
                height: 48.0,
                child: InkWell(
                  onTap: () {
                    print("profile click");
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
                  localization.trans('MEMBER')!,
                  semanticsLabel: localization.trans('MEMBER'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: onSeeAllPressed as void Function()?,
                  child: Text(
                    localization.trans('SEE_ALL')!,
                    semanticsLabel: localization.trans('SEE_ALL'),
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
                                color: Asset.Colors.cloudyBlue,
                              ),
                            ),
                            child: InkWell(
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onTap: () {
                                print("add member");
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
