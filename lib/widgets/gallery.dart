import 'dart:io';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/models/ledger_item_model.dart';
import 'package:flutter/material.dart';
import 'package:wecount/models/photo_model.dart';

import 'package:wecount/screens/photo_detail.dart';
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

enum PhotoOption { camera, gallery }

Future<PhotoOption?> _asyncPhotoSelect(BuildContext context) async {
  return await showDialog<PhotoOption>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
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
                      color: Theme.of(context).textTheme.displayLarge!.color,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Text(
                        localization(context).camera,
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
                Navigator.pop(context, PhotoOption.gallery);
              },
              child: SizedBox(
                height: 44,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.photo,
                      color: Theme.of(context).textTheme.displayLarge!.color,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Text(
                        localization(context).gallery,
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
        );
      });
}

class Gallery extends HookWidget {
  const Gallery({
    super.key,
    this.margin,
    this.showAll = false,
    this.pictureProps = const [],
    required this.ledgerItem,
  });

  final EdgeInsets? margin;
  final bool showAll;
  final List<PhotoModel> pictureProps;
  final LedgerItemModel ledgerItem;

  @override
  Widget build(BuildContext context) {
    var ledgerItemState = useState(ledgerItem);
    var pictures = useState<List<PhotoModel>>([]);

    useEffect(() {
      pictures.value = pictureProps;
      return null;
    }, []);

    void onPressShowAll() {}

    return Container(
      margin: margin,
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
                        color: asset.Colors.cloudyBlue,
                      ),
                    ),
                    Text(
                      localization(context).picture,
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
                        localization(context).showAll,
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
            margin: const EdgeInsets.only(bottom: 32),
            child: Wrap(
              children: pictures.value.map((PhotoModel photo) {
                if (photo.isAddBtn == true) {
                  return Container(
                    padding: const EdgeInsets.only(right: 4, bottom: 6),
                    child: InkWell(
                      onTap: () async {
                        final PhotoOption? photoOption =
                            await _asyncPhotoSelect(context);
                        XFile? imgFile;
                        if (context.mounted) {}
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

                        if (context.mounted && imgFile != null) {
                          PhotoModel photo = PhotoModel(file: imgFile);
                          pictures.value.add(photo);
                          ledgerItemState.value =
                              ledgerItem.copyWith(picture: pictures.value);
                        }
                      },
                      child: Container(
                        width: 80,
                        height: 72,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: asset.Colors.cloudyBlue,
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
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
                              splashColor: asset.Colors.paleGray,
                              onTap: () => navigation.navigate(
                                context,
                                AppRoute.photoDetail.path,
                                arguments: PhotoDetailArguments(
                                  photo: photo,
                                  onPressDelete: () {
                                    int index = pictures.value.indexWhere(
                                        (PhotoModel compare) =>
                                            compare.file == photo.file);
                                    pictures.value.removeAt(index);
                                    ledgerItemState.value = ledgerItem.copyWith(
                                        picture: pictures.value);
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
