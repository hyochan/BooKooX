import 'dart:io';

import 'package:bookoox/models/LedgerItem.dart';
import 'package:flutter/material.dart';

import 'package:bookoox/screens/photo_detail.dart';
import 'package:bookoox/models/Photo.dart';
import 'package:bookoox/utils/asset.dart' as Asset;
import 'package:bookoox/utils/localization.dart' show Localization;
import 'package:bookoox/utils/general.dart' show General;

enum PhotoOption { Camera, Gallery }

Future<PhotoOption> _asyncPhotoSelect(BuildContext context) async {
  var _localization = Localization.of(context);

  return await showDialog<PhotoOption>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return SimpleDialog(
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, PhotoOption.Camera);
            },
            child: Container(
              height: 44,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.camera,
                    color: Theme.of(context).textTheme.headline1.color,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                      _localization.trans('CAMERA'),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.headline1.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, PhotoOption.Gallery);
            },
            child: Container(
              height: 44,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.photo,
                    color: Theme.of(context).textTheme.headline1.color,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                      _localization.trans('GALLERY'),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.headline1.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        backgroundColor: Theme.of(context).backgroundColor,
      );
    });
}

class Gallery extends StatefulWidget {
  Gallery({
    this.margin,
    this.showAll = false,
    @required this.picture,
    @required this.ledgerItem,
  });

  final EdgeInsets margin;
  final bool showAll;
  final List<Photo> picture;
  final LedgerItem ledgerItem;

  @override
  _GalleryState createState() => _GalleryState(picture);
}

class _GalleryState extends State<Gallery> {
  List<Photo> picture;

  _GalleryState(List<Photo> picture) {
    this.picture = picture;
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);

    void onPressShowAll() {

    }

    return Container(
      margin: widget.margin,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 18),
                      width: 20.0,
                      child: Icon(
                        Icons.photo,
                        color: Asset.Colors.cloudyBlue,
                      ),
                    ),
                    Text(
                      _localization.trans('PICTURE'),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline1.color,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              widget.showAll
              ? FlatButton(
                onPressed: onPressShowAll,
                child: Text(
                  _localization.trans('SHOW_ALL'),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline1.color,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ) : Container(),
            ],
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 32),
            child: Wrap(
              children: this.picture.map((Photo photo) {
                if (photo.isAddBtn == true) {
                  return Container(
                    padding: EdgeInsets.only(right: 4, bottom: 6),
                    child: FlatButton(
                      onPressed: () async {
                        final PhotoOption photoOption = await _asyncPhotoSelect(context);
                        File imgFile;
                        switch (photoOption) {
                          case PhotoOption.Camera:
                            imgFile = await General.instance.chooseImage(context: context, type: 'camera');
                            break;
                          case PhotoOption.Gallery:
                            imgFile = await General.instance.chooseImage(context: context, type: 'gallery');
                            break;
                        }

                        if (imgFile != null) {
                          Photo photo = new Photo(file: imgFile);
                          this.picture.add(photo);
                          widget.ledgerItem.picture = this.picture;
                        }
                      },
                      padding: EdgeInsets.all(0),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Container(
                        width: 80,
                        height: 72,
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).textTheme.headline1.color,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: Asset.Colors.cloudyBlue,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                if (photo.file != null) {
                  return Container(
                    height: 72,
                    width: 84,
                    margin: EdgeInsets.only(right: 8, bottom: 6),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          left: 4,
                          child: Image.file(
                            photo.file,
                            fit: BoxFit.cover,
                            height: 72,
                            width: 84,
                          ),
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Asset.Colors.paleGray,
                              onTap: () => General.instance.navigateScreen(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => PhotoDetail(
                                    photo: photo,
                                    onPressDelete: () {
                                      int index = this.picture.indexWhere((Photo compare) => compare.file == photo.file);
                                      this.picture.removeAt(index);
                                      widget.ledgerItem.picture = this.picture;
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}