import 'package:get/get.dart';
import 'package:wecount/models/user_model.dart' show UserModel;
import 'package:wecount/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase show User;
import 'package:flutter/material.dart';

import 'package:wecount/shared/header.dart' show renderHeaderClose;
import 'package:wecount/shared/edit_text_box.dart' show EditTextBox;
import 'package:wecount/shared/profile_image_cam.dart';
import 'package:wecount/utils/general.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../utils/localization.dart';

class ProfileMy extends StatefulWidget {
  static const String name = '/profile_my';

  const ProfileMy({Key? key}) : super(key: key);

  @override
  State<ProfileMy> createState() => _ProfileMyState();
}

class _ProfileMyState extends State<ProfileMy> {
  XFile? _imgFile;
  UserModel? _profile;

  Future<void> _onUpdateProfile() async {
    General.instance.showSpinnerDialog();

    await DatabaseService().requestUpdateProfile(
      _profile,
      imgFile: _imgFile,
    );

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<firebase.User>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderClose(
        context: context,
        brightness: Theme.of(context).brightness,
        actions: [
          IconButton(
            icon: Icon(
              Icons.save_alt,
              semanticLabel: t('UPDATE'),
            ),
            color: Theme.of(context).textTheme.headline1!.color,
            padding: const EdgeInsets.all(0.0),
            onPressed: _onUpdateProfile,
          ),
        ],
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: DatabaseService().streamUser(user.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return Container();

          var user = snapshot.data;
          _profile = UserModel(
            email: user.email ?? '',
            displayName: user.displayName ?? '',
            phoneNumber: user.phoneNumber ?? '',
            uid: user.uid,
            statusMsg: user.statusMsg ?? '',
            photoURL: user.photoURL,
            thumbURL: user.thumbURL,
          );

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 24, bottom: 8),
                child: Row(
                  children: <Widget>[
                    ProfileImageCam(
                      imgFile: _imgFile,
                      imgStr: _profile!.thumbURL ?? _profile!.photoURL,
                      selectCamera: () async {
                        var file = await General.instance
                            .chooseImage(context: context, type: 'camera');
                        if (file != null) {
                          setState(() => _imgFile = file);
                        }
                      },
                      selectGallery: () async {
                        var file = await General.instance
                            .chooseImage(context: context, type: 'gallery');
                        if (file != null) {
                          setState(() => _imgFile = file);
                        }
                      },
                    ),
                  ],
                ),
              ),
              EditTextBox(
                controller: TextEditingController(
                  text: user.email,
                ),
                enabled: false,
                iconData: Icons.email,
                margin: const EdgeInsets.only(top: 24.0),
                hintText: t('EMAIL'),
                focusedColor: Theme.of(context).textTheme.headline1!.color,
                enabledColor: Theme.of(context).textTheme.headline2!.color,
              ),
              EditTextBox(
                controller: TextEditingController(
                  text: user.displayName,
                ),
                onChangeText: (String str) => _profile!.displayName = str,
                semanticLabel: t('NICKNAME'),
                iconData: Icons.person_outline,
                margin: const EdgeInsets.only(top: 8.0),
                hintText: t('NICKNAME'),
                focusedColor: Theme.of(context).textTheme.headline1!.color,
                enabledColor: Theme.of(context).textTheme.headline2!.color,
              ),
              EditTextBox(
                controller: TextEditingController(
                  text: user.phoneNumber,
                ),
                onChangeText: (String str) => _profile!.phoneNumber = str,
                iconData: Icons.phone,
                margin: const EdgeInsets.only(top: 8.0),
                hintText: t('PHONE'),
                focusedColor: Theme.of(context).textTheme.headline1!.color,
                enabledColor: Theme.of(context).textTheme.headline2!.color,
              ),
              Container(
                margin: const EdgeInsets.only(top: 32.0, bottom: 12.0),
                child: const Divider(
                  height: 1.0,
                ),
              ),
              EditTextBox(
                controller: TextEditingController(
                  text: user.statusMsg,
                ),
                onChangeText: (String str) => _profile!.statusMsg = str,
                labelText: t('STATUS_MESSAGE'),
                hintText: t('STATUS_MESSAGE_HINT'),
                maxLines: 5,
              ),
            ],
          );
        },
      )),
    );
  }
}
