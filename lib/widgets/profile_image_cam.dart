import 'dart:io';

import 'package:flutter/material.dart';

import 'package:wecount/utils/asset.dart' as asset;
import 'package:image_picker/image_picker.dart';

class ProfileImageCam extends StatelessWidget {
  final Function? selectGallery;
  final Function? selectCamera;
  final XFile? imgFile;
  final String? imgPath;

  const ProfileImageCam({
    super.key,
    this.selectGallery,
    this.selectCamera,
    this.imgFile,
    this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(0.0),
          child: Stack(
            children: <Widget>[
              SizedBox(
                width: 88.0,
                height: 88.0,
                child: imgPath == null && imgFile == null
                    ? ClipOval(
                        child: Material(
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: Ink.image(
                              image: asset.Icons.icMask,
                              fit: BoxFit.cover,
                              width: 80.0,
                              height: 80.0,
                              child: InkWell(
                                onTap: selectGallery as void Function()?,
                              ),
                            )))
                    : imgFile != null
                        ? TextButton(
                            onPressed: selectGallery as void Function()?,
                            child: CircleAvatar(
                              backgroundImage: FileImage(File(imgFile!.path)),
                              radius: 80.0,
                            ),
                          )
                        : Material(
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: TextButton(
                              onPressed: selectGallery as void Function()?,
                              child: ClipOval(
                                child: FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    placeholder: 'res/icons/icMask.png',
                                    image: imgPath ?? ''),
                              ),
                            ),
                          ),
              ),
              Positioned(
                right: 0.0,
                bottom: 0.0,
                width: 36.0,
                height: 36.0,
                child: ClipOval(
                  child: TextButton(
                    onPressed: selectCamera as void Function()?,
                    child: const Icon(
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
