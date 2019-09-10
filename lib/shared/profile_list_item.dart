import 'package:flutter/material.dart';
import 'package:bookoo2/utils/asset.dart' as Asset;

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
    this.key,
    this.imageString,
    this.displayName,
    this.email,
    this.onTap,
  });

  final Key key;
  final String imageString;
  final String displayName;
  final String email;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 28.0),
      padding: EdgeInsets.only(left: 24.0, right: 20.0, top: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipOval(
            child: Material(
              // borderRadius: BorderRadius.circular(40.0),
              clipBehavior: Clip.hardEdge,
              color: Colors.transparent,
              child: Ink.image(
                image: Asset.Icons.icMask,
                fit: BoxFit.cover,
                width: 80.0,
                height: 80.0,
                child: InkWell(
                  onTap: this.onTap,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    displayName,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                    ),
                  ),
                ),
               Container(
                  child: Text(
                    email,
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
