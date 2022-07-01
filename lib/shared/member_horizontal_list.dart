import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecount/models/user.dart';
import 'package:wecount/screens/search_user.dart';
import 'package:wecount/services/database.dart';
import 'package:wecount/shared/network_image_loader.dart';
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/localization.dart';

import '../screens/empty.dart';
import '../utils/alert.dart';

class MemberHorizontalList extends StatefulWidget {
  final bool? showAddBtn;
  final void Function()? onSeeAllPressed;
  final Color backgroundColor;
  final List<String> memberIds;

  const MemberHorizontalList({
    Key? key,
    this.showAddBtn,
    this.onSeeAllPressed,
    required this.backgroundColor,
    this.memberIds = const [],
  }) : super(key: key);

  @override
  State<MemberHorizontalList> createState() => _MemberHorizontalListState();
}

class _MemberHorizontalListState extends State<MemberHorizontalList> {
  List<String> _memberIds = [];

  @override
  void initState() {
    _memberIds = widget.memberIds;
    super.initState();
  }

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
              onPressed: widget.onSeeAllPressed,
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
            _memberIds.isEmpty
                ? const Empty()
                : Stack(
                    children: _memberIds.take(4).mapIndexed((index, memberId) {
                      if (index > 0) {
                        memberIconLeftMargin +=
                            _memberIds.length <= 3 ? 52 : 37;
                      }

                      return Container(
                        width: 55,
                        height: 55,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: widget.backgroundColor,
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
                                    AsyncSnapshot<User> snapshot) {
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
                                    "+ ${_memberIds.length}",
                                    style: TextStyle(
                                      color: widget.backgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                      );
                    }).toList(),
                  ),
            widget.showAddBtn == true
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
                            User? user = await Get.to(() => const SearchUser());

                            if (user != null) {
                              if (_memberIds.contains(user.uid!)) {
                                return alert(
                                  t('ALREADY_MEMBER_WARNING'),
                                  colorText: Colors.white,
                                );
                              }

                              setState(
                                () => _memberIds.add(user.uid!),
                              );
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
