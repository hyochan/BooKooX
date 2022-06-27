import 'dart:io';

import 'package:photo_view/photo_view.dart'
    show PhotoView, PhotoViewComputedScale;
import 'package:flutter/material.dart';

import 'package:wecount/models/photo.dart';

import '../utils/localization.dart';

class PhotoDetail extends StatefulWidget {
  PhotoDetail({
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
  _State createState() => _State();
}

class _State extends State<PhotoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PhotoView(
              imageProvider: widget.photoUrl != null
                  ? NetworkImage(widget.photoUrl!)
                  : widget.photo != null && widget.photo!.file != null
                      ? FileImage(File(widget.photo!.file!.path))
                      : (widget.photo != null && widget.photo!.url != null
                              ? NetworkImage(widget.photo!.url!)
                              : AssetImage('res/icons/icMask.png'))
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
                  Container(
                    width: 60.0,
                    height: 60.0,
                    child: RawMaterialButton(
                      padding: EdgeInsets.all(0.0),
                      shape: CircleBorder(),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        semanticLabel: t('BACK'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: widget.canShare
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.center,
                  children: <Widget>[
                    widget.canShare
                        ? Container(
                            width: 60.0,
                            height: 60.0,
                            child: RawMaterialButton(
                              padding: EdgeInsets.all(0.0),
                              shape: CircleBorder(),
                              onPressed:
                                  widget.onPressDownload as void Function()?,
                              child: Icon(
                                Icons.file_download,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(),
                    widget.canShare
                        ? Container(
                            width: 60.0,
                            height: 60.0,
                            child: RawMaterialButton(
                              padding: EdgeInsets.all(0.0),
                              shape: CircleBorder(),
                              onPressed:
                                  widget.onPressShare as void Function()?,
                              child: Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(),
                    widget.onPressDelete != null
                        ? Container(
                            width: 60.0,
                            height: 60.0,
                            child: RawMaterialButton(
                              padding: EdgeInsets.all(0.0),
                              shape: CircleBorder(),
                              onPressed:
                                  widget.onPressDelete as void Function()?,
                              child: Icon(
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
