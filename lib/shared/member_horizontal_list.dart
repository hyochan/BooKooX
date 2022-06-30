import 'package:flutter/material.dart';
import 'package:wecount/models/user.dart';
import 'package:wecount/services/database.dart';
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/localization.dart';

import '../screens/empty.dart';

class MemberHorizontalList extends StatelessWidget {
  final bool? showAddBtn;
  final void Function()? onSeeAllPressed;

  final List<String> memberIds;

  const MemberHorizontalList({
    Key? key,
    this.showAddBtn,
    this.onSeeAllPressed,
    this.memberIds = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> memberWidgets = memberIds.map((memberId) {
      return StreamBuilder(
        stream: DatabaseService().streamUser(memberId),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          return Container(
            margin: const EdgeInsets.only(left: 8),
            child: Material(
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Ink.image(
                  image: (!snapshot.hasData ||
                          (snapshot.data!.photoURL == null &&
                              snapshot.data!.thumbURL == null)
                      ? asset.Icons.icMask
                      : NetworkImage(snapshot.data!.thumbURL != null
                          ? snapshot.data!.thumbURL!
                          : snapshot.data!.photoURL!)) as ImageProvider<Object>,
                  fit: BoxFit.cover,
                  width: 48.0,
                  height: 48.0,
                  child: InkWell(
                    onTap: () {},
                  ),
                )),
          );
        },
      );
    }).toList();

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
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              showAddBtn == true
                  ? Material(
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.0,
                            color: Colors.white,
                          ),
                        ),
                        child: InkWell(
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onTap: () {},
                        ),
                      ),
                    )
                  : const Empty(),
              Row(
                children: memberWidgets,
              ),
            ],
          ),
        )
      ],
    );
  }
}
