import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/repositories/user_repository.dart';
import 'package:wecount/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth show User;
import 'package:flutter/material.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/navigation.dart';

import 'package:wecount/widgets/header.dart' show renderHeaderClose;
import 'package:wecount/widgets/edit_text_box.dart' show EditTextBox;
import 'package:wecount/widgets/profile_image_cam.dart';
import 'package:wecount/utils/localization.dart' show Localization;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileMy extends HookWidget {
  const ProfileMy({super.key});

  @override
  Widget build(BuildContext context) {
    var imgFile = useState<XFile?>(null);
    UserModel? profile;

    Future<void> onUpdateProfile() async {
      General.instance.showDialogSpinner(context);

      await DatabaseService().requestUpdateProfile(
        profile,
        imgFile: imgFile.value,
      );

      if (context.mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    }

    var localization = Localization.of(context)!;
    // var user0 = Provider.of<FireAuth.User>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: renderHeaderClose(
        context: context,
        brightness: Theme.of(context).brightness,
        actions: [
          IconButton(
            icon: Icon(
              Icons.save_alt,
              semanticLabel: localization.trans('UPDATE'),
            ),
            color: Theme.of(context).textTheme.displayLarge!.color,
            padding: const EdgeInsets.all(0.0),
            onPressed: onUpdateProfile,
          ),
        ],
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: UserRepository.instance.getMe(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return const SizedBox();

          UserModel user = snapshot.data;
          profile = UserModel(
              email: user.email ?? '',
              displayName: user.displayName,
              phoneNumber: user.phoneNumber ?? '',
              uid: user.uid,
              statusMsg: user.statusMsg ?? '',
              photoURL: user.photoURL,
              thumbURL: user.thumbURL,
              createdAt: user.createdAt);

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 24, bottom: 8),
                child: Row(
                  children: <Widget>[
                    ProfileImageCam(
                      imgFile: imgFile.value,
                      imgStr: profile?.thumbURL != null
                          ? profile!.thumbURL
                          : profile?.photoURL,
                      selectCamera: () async {
                        var file = await General.instance
                            .chooseImage(context: context, type: 'camera');
                        if (file != null) {
                          imgFile.value = file;
                        }
                      },
                      selectGallery: () async {
                        var file = await General.instance
                            .chooseImage(context: context, type: 'gallery');
                        if (file != null) {
                          imgFile.value = file;
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
                hintText: localization.trans('EMAIL'),
                focusedColor: Theme.of(context).textTheme.displayLarge!.color,
                enabledColor: Theme.of(context).textTheme.displayMedium!.color,
              ),
              EditTextBox(
                controller: TextEditingController(
                  text: user.displayName,
                ),
                onChangeText: (String str) =>
                    profile = profile?.copyWith(displayName: str),
                semanticLabel: localization.trans('NICKNAME'),
                iconData: Icons.person_outline,
                margin: const EdgeInsets.only(top: 8.0),
                hintText: localization.trans('NICKNAME'),
                focusedColor: Theme.of(context).textTheme.displayLarge!.color,
                enabledColor: Theme.of(context).textTheme.displayMedium!.color,
              ),
              EditTextBox(
                controller: TextEditingController(
                  text: user.phoneNumber,
                ),
                onChangeText: (String str) =>
                    profile = profile?.copyWith(phoneNumber: str),
                iconData: Icons.phone,
                margin: const EdgeInsets.only(top: 8.0),
                hintText: localization.trans('PHONE'),
                focusedColor: Theme.of(context).textTheme.displayLarge!.color,
                enabledColor: Theme.of(context).textTheme.displayMedium!.color,
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
                onChangeText: (String str) =>
                    profile = profile?.copyWith(statusMsg: str),
                labelText: localization.trans('STATUS_MESSAGE'),
                hintText: localization.trans('STATUS_MESSAGE_HINT'),
                maxLines: 5,
              ),
            ],
          );
        },
      )),
    );
  }
}
