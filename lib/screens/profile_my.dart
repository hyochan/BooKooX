import 'package:wecount/models/user.dart' show User;
import 'package:wecount/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart' as FireAuth show User;
import 'package:flutter/material.dart';
import 'package:wecount/utils/navigation.dart';

import 'package:wecount/widgets/header.dart' show renderHeaderClose;
import 'package:wecount/widgets/edit_text_box.dart' show EditTextBox;
import 'package:wecount/widgets/profile_image_cam.dart';
import 'package:wecount/utils/localization.dart' show Localization;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileMy extends StatefulWidget {
  const ProfileMy({Key? key}) : super(key: key);

  @override
  _ProfileMyState createState() => _ProfileMyState();
}

class _ProfileMyState extends State<ProfileMy> {
  XFile? _imgFile;
  User? _profile;

  Future<void> _onUpdateProfile() async {
    navigation.showDialogSpinner(context);

    await DatabaseService().requestUpdateProfile(
      _profile,
      imgFile: _imgFile,
    );

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context)!;
    var _user = Provider.of<FireAuth.User>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: renderHeaderClose(
        context: context,
        brightness: Theme.of(context).brightness,
        actions: [
          IconButton(
            icon: Icon(
              Icons.save_alt,
              semanticLabel: _localization.trans('UPDATE'),
            ),
            color: Theme.of(context).textTheme.displayLarge!.color,
            padding: EdgeInsets.all(0.0),
            onPressed: _onUpdateProfile,
          ),
        ],
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: DatabaseService().streamUser(_user.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return Container();

          var user = snapshot.data;
          _profile = User(
            email: user.email ?? '',
            displayName: user.displayName ?? '',
            phoneNumber: user.phoneNumber ?? '',
            uid: user.uid,
            statusMsg: user.statusMsg ?? '',
            photoURL: user.photoURL,
            thumbURL: user.thumbURL,
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
                      imgStr: _profile!.thumbURL != null
                          ? _profile!.thumbURL
                          : _profile!.photoURL,
                      selectCamera: () async {
                        var file = await navigation.chooseImage(
                            context: context, type: 'camera');
                        if (file != null) {
                          setState(() => _imgFile = file);
                        }
                      },
                      selectGallery: () async {
                        var file = await navigation.chooseImage(
                            context: context, type: 'gallery');
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
                focusedColor: Theme.of(context).textTheme.displayLarge!.color,
                enabledColor: Theme.of(context).textTheme.displayMedium!.color,
              ),
              EditTextBox(
                controller: TextEditingController(
                  text: user.displayName,
                ),
                onChangeText: (String str) => _profile!.displayName = str,
                semanticLabel: _localization.trans('NICKNAME'),
                iconData: Icons.person_outline,
                margin: EdgeInsets.only(top: 8.0),
                hintText: _localization.trans('NICKNAME'),
                focusedColor: Theme.of(context).textTheme.displayLarge!.color,
                enabledColor: Theme.of(context).textTheme.displayMedium!.color,
              ),
              EditTextBox(
                controller: TextEditingController(
                  text: user.phoneNumber,
                ),
                onChangeText: (String str) => _profile!.phoneNumber = str,
                iconData: Icons.phone,
                margin: EdgeInsets.only(top: 8.0),
                hintText: _localization.trans('PHONE'),
                focusedColor: Theme.of(context).textTheme.displayLarge!.color,
                enabledColor: Theme.of(context).textTheme.displayMedium!.color,
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
                onChangeText: (String str) => _profile!.statusMsg = str,
                labelText: _localization.trans('STATUS_MESSAGE'),
                hintText: _localization.trans('STATUS_MESSAGE_HINT'),
                maxLines: 5,
              ),
            ],
          );
        },
      )),
    );
  }
}
