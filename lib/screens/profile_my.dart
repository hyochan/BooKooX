import 'package:flutter/material.dart';

import 'package:bookoox/shared/header.dart' show renderHeaderClose;
import 'package:bookoox/shared/edit_text_box.dart' show EditTextBox;
import 'package:bookoox/shared/profile_image_cam.dart';
import 'package:bookoox/utils/general.dart';
import 'package:bookoox/utils/localization.dart' show Localization;

class ProfileMy extends StatefulWidget {
  @override
  _ProfileMyState createState() => _ProfileMyState();
}

class _ProfileMyState extends State<ProfileMy> {
  void _onUpdateProfile() {
    print('onUpdateProfile');
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderClose(
        context: context,
        brightness: Theme.of(context).brightness,
        actions: [
          IconButton(
            icon: Icon(
              Icons.save_alt,
              semanticLabel: 'update',
            ),
            color: Theme.of(context).textTheme.headline1.color,
            padding: EdgeInsets.all(0.0),
            onPressed: _onUpdateProfile,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 24, bottom: 8),
              child: Row(
                children: <Widget>[
                  ProfileImageCam(
                    selectCamera: () => General.instance.chooseImage(context: context, type: 'camera'),
                    selectGallery: () => General.instance.chooseImage(context: context, type: 'gallery'),
                  ),
                ],
              ),
            ),
            EditTextBox(
              iconData: Icons.person_outline,
              margin: EdgeInsets.only(top: 24.0),
              hintText: _localization.trans('NICKNAME'),
              focusedColor: Theme.of(context).textTheme.headline1.color,
              enabledColor: Theme.of(context).textTheme.headline2.color,
            ),
            EditTextBox(
              iconData: Icons.email,
              margin: EdgeInsets.only(top: 8.0),
              hintText: _localization.trans('EMAIL'),
              focusedColor: Theme.of(context).textTheme.headline1.color,
              enabledColor: Theme.of(context).textTheme.headline2.color,
            ),
            EditTextBox(
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
              labelText: _localization.trans('STATUS_MESSAGE'),
              hintText: _localization.trans('STATUS_MESSAGE_HINT'),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
