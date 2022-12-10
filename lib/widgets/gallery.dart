import 'dart:io';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:flutter/material.dart';

import 'package:wecount/screens/photo_detail.dart';
import 'package:wecount/models/photo.dart';
import 'package:wecount/utils/asset.dart' as Asset;
import 'package:wecount/utils/localization.dart' show Localization;
import 'package:image_picker/image_picker.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

enum PhotoOption { Camera, Gallery }

Future<PhotoOption?> _asyncPhotoSelect(BuildContext context) async {
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
                      color: Theme.of(context).textTheme.displayLarge!.color,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text(
                        _localization!.trans('CAMERA')!,
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
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
                      color: Theme.of(context).textTheme.displayLarge!.color,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text(
                        _localization.trans('GALLERY')!,
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.background,
        );
      });
}

class Gallery extends HookWidget {
  Gallery({
    this.margin,
    this.showAll = false,
    this.pictures = const [],
    required this.ledgerItem,
  });

  final EdgeInsets? margin;
  final bool showAll;
  final List<Photo> pictures;
  final LedgerItem ledgerItem;

  @override
  Widget build(BuildContext context) {
    var _pictures = useState<List<Photo>>([]);

    useEffect(() {
      _pictures.value = pictures;
    }, []);

    var _localization = Localization.of(context)!;

    void onPressShowAll() {}

    return Container(
      margin: margin,
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
                      _localization.trans('PICTURE')!,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displayLarge!.color,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              showAll
                  ? TextButton(
                      onPressed: onPressShowAll,
                      child: Text(
                        _localization.trans('SHOW_ALL')!,
                        style: TextStyle(
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
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
            margin: EdgeInsets.only(bottom: 32),
            child: Wrap(
              children: _pictures.value.map((Photo photo) {
                if (photo.isAddBtn == true) {
                  return Container(
                    padding: EdgeInsets.only(right: 4, bottom: 6),
                    child: InkWell(
                      onTap: () async {
                        final PhotoOption? photoOption =
                            await _asyncPhotoSelect(context);
                        XFile? imgFile;
                        switch (photoOption) {
                          case PhotoOption.Camera:
                            imgFile = await navigation.chooseImage(
                                context: context, type: 'camera');
                            break;
                          case PhotoOption.Gallery:
                            imgFile = await navigation.chooseImage(
                                context: context, type: 'gallery');
                            break;
                          default:
                            break;
                        }

                        if (imgFile != null) {
                          Photo photo = Photo(file: imgFile);
                          _pictures.value.add(photo);
                          ledgerItem.picture = _pictures.value;
                        }
                      },
                      child: Container(
                        width: 80,
                        height: 72,
                        child: Icon(
                          Icons.add,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
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
                              splashColor: Asset.Colors.paleGray,
                              onTap: () => navigation.navigate(
                                context,
                                AppRoute.photoDetail.path,
                                arguments: PhotoDetailArguments(
                                  photo: photo,
                                  onPressDelete: () {
                                    int index = _pictures.value.indexWhere(
                                        (Photo compare) =>
                                            compare.file == photo.file);
                                    _pictures.value.removeAt(index);
                                    ledgerItem.picture = _pictures.value;
                                    Navigator.of(context).pop();
                                  },
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
