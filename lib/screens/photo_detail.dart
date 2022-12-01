import 'dart:io';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photo_view/photo_view.dart'
    show PhotoView, PhotoViewComputedScale;
import 'package:flutter/material.dart';
import 'package:wecount/models/ledger_item.dart';

import 'package:wecount/utils/localization.dart' show Localization;

class PhotoDetailArguments {
  final Photo? photo;
  final String? photoUrl;
  final bool canShare;
  final Function? onPressDelete;
  final Function? onPressShare;
  final Function? onPressDownload;

  PhotoDetailArguments({
    this.photo,
    this.photoUrl,
    this.canShare = false,
    this.onPressDelete,
    this.onPressShare,
    this.onPressDownload,
  });
}

class PhotoDetail extends HookWidget {
  const PhotoDetail({
    Key? key,
    this.photo,
    this.photoUrl,
    this.canShare = false,
    this.onPressDelete,
    this.onPressShare,
    this.onPressDownload,
  }) : super(key: key);
  final Photo? photo;
  final String? photoUrl;
  final bool canShare;
  final Function? onPressDelete;
  final Function? onPressShare;
  final Function? onPressDownload;

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context)!;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PhotoView(
              imageProvider: photoUrl != null
                  ? NetworkImage(photoUrl!)
                  : photo != null && photo!.file != null
                      ? FileImage(File(photo!.file!.path))
                      : (photo != null && photo!.url != null
                              ? NetworkImage(photo!.url!)
                              : const AssetImage('res/icons/icMask.png'))
                          as ImageProvider<Object>?,
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: 4.0,
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: 60.0,
                    height: 60.0,
                    child: RawMaterialButton(
                      padding: const EdgeInsets.all(0.0),
                      shape: const CircleBorder(),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        semanticLabel: localization.trans('BACK'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: SizedBox(
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: canShare
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.center,
                  children: <Widget>[
                    canShare
                        ? SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: RawMaterialButton(
                              padding: const EdgeInsets.all(0.0),
                              shape: const CircleBorder(),
                              onPressed: onPressDownload as void Function()?,
                              child: const Icon(
                                Icons.file_download,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(),
                    canShare
                        ? SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: RawMaterialButton(
                              padding: const EdgeInsets.all(0.0),
                              shape: const CircleBorder(),
                              onPressed: onPressShare as void Function()?,
                              child: const Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(),
                    onPressDelete != null
                        ? SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: RawMaterialButton(
                              padding: const EdgeInsets.all(0.0),
                              shape: const CircleBorder(),
                              onPressed: onPressDelete as void Function()?,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
