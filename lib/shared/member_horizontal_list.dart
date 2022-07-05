import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/screens/search_user.dart';
import 'package:wecount/services/database.dart';
import 'package:wecount/shared/network_image_loader.dart';
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/localization.dart';

import '../screens/empty.dart';
import '../utils/alert.dart';

class MemberHorizontalList extends StatelessWidget {
  final bool? showAddBtn;
  final void Function()? onSeeAllPressed;
  final Color backgroundColor;
  final List<String> memberIds;
  final dynamic Function(List<String> memberIds)? onMemberChanged;

  const MemberHorizontalList({
    Key? key,
    this.showAddBtn,
    this.onSeeAllPressed,
    required this.backgroundColor,
    this.memberIds = const [],
    this.onMemberChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double memberIconLeftMargin = 0;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              t('MEMBER'),
              semanticsLabel: t('MEMBER'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
              onPressed: onSeeAllPressed,
              child: Text(
                t('SEE_ALL'),
                semanticsLabel: t('SEE_ALL'),
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
        Row(
          children: [
            memberIds.isEmpty
                ? const Empty()
                : Stack(
                    children: memberIds.take(4).mapIndexed((index, memberId) {
                      if (index > 0) {
                        memberIconLeftMargin += memberIds.length <= 3 ? 52 : 37;
                      }

                      return Container(
                        width: 55,
                        height: 55,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          shape: BoxShape.circle,
                        ),
                        margin: EdgeInsets.only(
                          left: memberIconLeftMargin,
                          right: 5,
                        ),
                        child: index < 3
                            ? StreamBuilder(
                                stream: DatabaseService().streamUser(memberId),
                                builder: (BuildContext context,
                                    AsyncSnapshot<UserModel> snapshot) {
                                  return NetworkImageLoader(
                                    imageURL: snapshot.data?.thumbURL ??
                                        snapshot.data?.photoURL,
                                    emptyImage: Image(
                                      image: asset.Icons.icMask,
                                    ),
                                  );
                                },
                              )
                            : Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.white,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "+ ${memberIds.length}",
                                    style: TextStyle(
                                      color: backgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                      );
                    }).toList(),
                  ),
            showAddBtn == true
                ? Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.0,
                            color: Colors.white,
                          ),
                        ),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onTap: () async {
                            UserModel? user =
                                await Get.to(() => const SearchUser());

                            if (user != null) {
                              if (memberIds.contains(user.uid!)) {
                                return alert(
                                  t('ALREADY_MEMBER_WARNING'),
                                  colorText: Colors.white,
                                );
                              }

                              if (onMemberChanged != null) {
                                onMemberChanged!([
                                  ...memberIds,
                                  user.uid!,
                                ]);
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  )
                : const Empty(),
          ],
        )
      ],
    );
  }
}
