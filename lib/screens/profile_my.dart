import 'dart:io';

import 'package:bookoox/models/User.dart' show User;
import 'package:bookoox/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:bookoox/shared/header.dart' show renderHeaderClose;
import 'package:bookoox/shared/edit_text_box.dart' show EditTextBox;
import 'package:bookoox/shared/profile_image_cam.dart';
import 'package:bookoox/utils/general.dart';
import 'package:bookoox/utils/localization.dart' show Localization;
import 'package:provider/provider.dart';

class ProfileMy extends StatefulWidget {
  @override
  _ProfileMyState createState() => _ProfileMyState();
}

class _ProfileMyState extends State<ProfileMy> {
  File _imgFile;
  User _profile;

  void _onUpdateProfile() {
    print('onUpdateProfile');
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);
    var _user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderClose(
        context: context,
        brightness: Theme.of(context).brightness,
        actions: [
          IconButton(
            icon: Icon(
              Icons.save_alt,
              semanticLabel: _localization.trans('UPDATE'),
            ),
            color: Theme.of(context).textTheme.headline1.color,
            padding: EdgeInsets.all(0.0),
            onPressed: _onUpdateProfile,
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: DatabaseService().streamUser(_user.uid),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (!snapshot.hasData) return Container();

            var user = snapshot.data;
            _profile = User(
              email: user.email ?? '',
              displayName: user.displayName ?? '',
              phoneNumber: user.phoneNumber ?? '',
              uid: user.uid,
              statusMsg: user.statusMsg ?? '',
            );

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 24, bottom: 8),
                  child: Row(
                    children: <Widget>[
                      ProfileImageCam(
                        imgFile: _imgFile,
                        imgStr: _profile.thumbURL != null ? _profile.thumbURL : _profile.photoURL,
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
                  margin: EdgeInsets.only(top: 24.0),
                  hintText: _localization.trans('EMAIL'),
                  focusedColor: Theme.of(context).textTheme.headline1.color,
                  enabledColor: Theme.of(context).textTheme.headline2.color,
                ),
                EditTextBox(
                  controller: TextEditingController(
                    text: user.displayName,
                  ),
                  onChangeText: (String str) => _profile.displayName = str,
                  semanticLabel: _localization.trans('NICKNAME'),
                  iconData: Icons.person_outline,
                  margin: EdgeInsets.only(top: 8.0),
                  hintText: _localization.trans('NICKNAME'),
                  focusedColor: Theme.of(context).textTheme.headline1.color,
                  enabledColor: Theme.of(context).textTheme.headline2.color,
                ),
                EditTextBox(
                  controller: TextEditingController(
                    text: user.phoneNumber,
                  ),
                  onChangeText: (String str) => _profile.phoneNumber = str,
                  iconData: Icons.phone,
                  margin: EdgeInsets.only(top: 8.0),
                  hintText: _localization.trans('PHONE'),
                  focusedColor: Theme.of(context).textTheme.headline1.color,
                  enabledColor: Theme.of(context).textTheme.headline2.color,
                ),
                Container(
                  margin: EdgeInsets.only(top: 32.0, bottom: 12.0),
                  child: Divider(
                    height: 1.0,
                  ),
                ),
                EditTextBox(
                  controller: TextEditingController(
                    text: user.statusMsg,
                  ),
                  onChangeText: (String str) => _profile.statusMsg = str,
                  labelText: _localization.trans('STATUS_MESSAGE'),
                  hintText: _localization.trans('STATUS_MESSAGE_HINT'),
                  maxLines: 5,
                ),
              ],
            );
          },
        )
      ),
    );
  }
}
