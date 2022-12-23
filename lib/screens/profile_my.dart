import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/repositories/user_repository.dart';
import 'package:wecount/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth show User;
import 'package:flutter/material.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/widgets/common/edit_text.dart';

import 'package:wecount/widgets/header.dart' show renderHeaderClose;
import 'package:wecount/widgets/profile_image_cam.dart';
import 'package:wecount/utils/localization.dart';
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

    return Scaffold(
      backgroundColor: AppColors.bg.basic,
      appBar: renderHeaderClose(
        context: context,
        brightness: Theme.of(context).brightness,
        actions: [
          IconButton(
            icon: Icon(
              Icons.save_alt,
              semanticLabel: localization(context).update,
            ),
            color: AppColors.text.basic,
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
                      imgPath: profile?.thumbURL != null
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
              EditText(
                textEditingController: TextEditingController(
                  text: user.email,
                ),
                enabled: false,
                prefixIcon: const Icon(Icons.email),
                margin: const EdgeInsets.only(top: 24.0),
                textHint: localization(context).email,
              ),
              EditText(
                textEditingController: TextEditingController(
                  text: user.displayName,
                ),
                onChanged: (String str) =>
                    profile = profile?.copyWith(displayName: str),
                prefixIcon: const Icon(Icons.person_outline),
                margin: const EdgeInsets.only(top: 8.0),
                textHint: localization(context).nickname,
              ),
              EditText(
                textEditingController: TextEditingController(
                  text: user.phoneNumber,
                ),
                onChanged: (String str) =>
                    profile = profile?.copyWith(phoneNumber: str),
                prefixIcon: const Icon(Icons.phone),
                margin: const EdgeInsets.only(top: 8.0),
                textHint: localization(context).phone,
                cursorColor: AppColors.text.basic,
              ),
              Container(
                margin: const EdgeInsets.only(top: 32.0, bottom: 12.0),
                child: const Divider(
                  height: 1.0,
                ),
              ),
              EditText(
                textEditingController: TextEditingController(
                  text: user.statusMsg,
                ),
                onChanged: (String str) =>
                    profile = profile?.copyWith(statusMsg: str),
                label: localization(context).statusMessage,
                textHint: localization(context).statusMessageHint,
                maxLines: 5,
              ),
            ],
          );
        },
      )),
    );
  }
}
