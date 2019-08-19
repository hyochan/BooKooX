import 'package:flutter/material.dart';

import '../utils/asset.dart' as Asset;

class ProfileImageCam extends StatelessWidget {
  final Function selectGallery;
  final Function selectCamera;
  final String imgStr;

  ProfileImageCam({
    this.selectGallery,
    this.selectCamera,
    this.imgStr = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0.0),
          child: Stack(
            children: <Widget>[
              Container(
                width: 88.0,
                height: 88.0,
                child: ClipOval(
                  child: this.imgStr != null && this.imgStr != ''
                    ? Material(
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: Ink.image(
                        image: Asset.Icons.icMask,
                        fit: BoxFit.cover,
                        width: 80.0,
                        height: 80.0,
                        child: InkWell(
                          onTap: this.selectGallery,
                        ),
                      )
                    )
                    : Material(
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: FlatButton(
                        onPressed: this.selectGallery,
                        padding: EdgeInsets.all(0.0),
                        child: ClipOval(
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: 'res/icons/icMask.png',
                            image: 'https://picsum.photos/250?image=9',
                          ),
                        ),
                      ),
                    )
                ),
              ),
              Positioned(
                right: 0.0,
                bottom: 0.0,
                width: 36.0,
                height: 36.0,
                child: ClipOval(
                  child: FlatButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: this.selectCamera,
                    child: Icon(
                      Icons.camera,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}