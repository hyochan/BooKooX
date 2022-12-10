import 'package:flutter/material.dart';
import 'package:wecount/utils/asset.dart' as asset;

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
    super.key,
    this.imgPath,
    this.displayName,
    this.email,
    this.onTap,
  });

  final String? imgPath;
  final String? displayName;
  final String? email;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 28.0),
      padding: const EdgeInsets.only(left: 24.0, right: 20.0, top: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          imgPath != null
              ? Material(
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: TextButton(
                    onPressed: onTap as void Function()?,
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                          width: 80.0,
                          height: 80.0,
                          fit: BoxFit.cover,
                          placeholder: 'res/icons/icMask.png',
                          image: imgPath ?? ''),
                    ),
                  ),
                )
              : ClipOval(
                  child: Material(
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: Ink.image(
                      image: asset.Icons.icMask,
                      fit: BoxFit.cover,
                      width: 80.0,
                      height: 80.0,
                      child: InkWell(
                        onTap: onTap as void Function()?,
                      ),
                    ),
                  ),
                ),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    displayName!,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge!.color,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Text(
                  email!,
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 14.0,
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
