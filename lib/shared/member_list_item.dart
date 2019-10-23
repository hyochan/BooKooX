import 'package:bookoo2/models/User.dart';
import 'package:flutter/material.dart';

abstract class ListItem {}

class HeadingItem implements ListItem {
  final int numOfPeople;

  HeadingItem({
    this.numOfPeople = 0,
  });
}

class MemberItem implements ListItem {
  final User user;
  final Membership membership;

  MemberItem(this.user, this.membership);
}

class MemberListItem extends StatelessWidget {
  final Key key;
  final User user;
  final Membership membership;

  const MemberListItem({
    this.key,
    @required this.user,
    @required this.membership,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('member list item'),
    );
  }
}