import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/models/photo_model.dart';
import 'package:wecount/screens/photo_detail.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/general.dart' show General;

import '../utils/localization.dart';

enum PhotoOption { camera, gallery }

Future<PhotoOption?> _asyncPhotoSelect(BuildContext context) async {
  return await showDialog<PhotoOption>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, PhotoOption.camera);
              },
              child: SizedBox(
                height: 44,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.camera,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Text(
                        t('CAMERA'),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, PhotoOption.gallery);
              },
              child: SizedBox(
                height: 44,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.photo,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Text(
                        t('GALLERY'),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      });
}

class Gallery extends StatefulWidget {
  const Gallery({
    Key? key,
    this.margin,
    this.showAll = false,
    this.pictures = const [],
    required this.ledgerItem,
  }) : super(key: key);

  final EdgeInsets? margin;
  final bool showAll;
  final List<PhotoModel> pictures;
  final LedgerItemModel ledgerItem;

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late List<PhotoModel> _pictures;

  @override
  void initState() {
    _pictures = widget.pictures;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onPressShowAll() {}

    return Container(
      margin: widget.margin,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 18),
                      width: 20.0,
                      child: const Icon(
                        Icons.photo,
                        color: cloudyBlueColor,
                      ),
                    ),
                    Text(
                      t('PICTURE'),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline1!.color,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              widget.showAll
                  // ignore: deprecated_member_use
                  ? FlatButton(
                      onPressed: onPressShowAll,
                      child: Text(
                        t('SHOW_ALL'),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline1!.color,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 32),
            child: Wrap(
              children: _pictures.map((PhotoModel photo) {
                if (photo.isAddBtn == true) {
                  return Container(
                    padding: const EdgeInsets.only(right: 4, bottom: 6),
                    child: InkWell(
                      onTap: () async {
                        final PhotoOption? photoOption =
                            await _asyncPhotoSelect(context);
                        XFile? imgFile;
                        switch (photoOption) {
                          case PhotoOption.camera:
                            imgFile = await General.instance
                                .chooseImage(context: context, type: 'camera');
                            break;
                          case PhotoOption.gallery:
                            imgFile = await General.instance
                                .chooseImage(context: context, type: 'gallery');
                            break;
                          default:
                            break;
                        }

                        if (imgFile != null) {
                          PhotoModel photo = PhotoModel(file: imgFile);
                          setState(() {
                            _pictures.add(photo);
                          });
                          widget.ledgerItem.picture = _pictures;
                        }
                      },
                      child: Container(
                        width: 80,
                        height: 72,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: cloudyBlueColor,
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                    ),
                  );
                }
                if (photo.file != null) {
                  return Container(
                    height: 72,
                    width: 84,
                    margin: const EdgeInsets.only(right: 8, bottom: 6),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          left: 4,
                          child: Image.file(
                            File(photo.file!.path),
                            fit: BoxFit.cover,
                            height: 72,
                            width: 84,
                          ),
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: paleGrayColor,
                              onTap: () => General.instance.navigateScreen(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PhotoDetail(
                                    photo: photo,
                                    onPressDelete: () {
                                      int index = _pictures.indexWhere(
                                          (PhotoModel compare) =>
                                              compare.file == photo.file);
                                      _pictures.removeAt(index);
                                      widget.ledgerItem.picture = _pictures;
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
