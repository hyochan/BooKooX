import 'package:flutter_hooks/flutter_hooks.dart';
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

class ProfileMy extends HookWidget {
  const ProfileMy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _imgFile = useState<XFile?>(null);
    var _profile = useState<User?>(null);

    Future<void> _onUpdateProfile() async {
      navigation.showDialogSpinner(context);

      await DatabaseService().requestUpdateProfile(
        _profile.value,
        imgFile: _imgFile.value,
      );

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }

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
          _profile.value = User(
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
                      imgFile: _imgFile.value,
                      imgStr: _profile.value!.thumbURL != null
                          ? _profile.value!.thumbURL
                          : _profile.value!.photoURL,
                      selectCamera: () async {
                        var file = await navigation.chooseImage(
                            context: context, type: 'camera');
                        if (file != null) {
                          _imgFile.value = file;
                        }
                      },
                      selectGallery: () async {
                        var file = await navigation.chooseImage(
                            context: context, type: 'gallery');
                        if (file != null) {
                          _imgFile.value = file;
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
                onChangeText: (String str) => _profile.value!.displayName = str,
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
                onChangeText: (String str) => _profile.value!.phoneNumber = str,
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
                onChangeText: (String str) => _profile.value!.statusMsg = str,
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
