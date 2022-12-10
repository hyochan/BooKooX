import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/screens/photo_detail.dart';
import 'package:flutter/material.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

import 'package:wecount/widgets/header.dart' show renderHeaderClose;
import 'package:wecount/widgets/edit_text_box.dart' show EditTextBox;
import 'package:wecount/utils/localization.dart';

class ProfilePeerArguments {
  final UserModel user;

  ProfilePeerArguments({required this.user});
}

class ProfilePeer extends HookWidget {
  final UserModel user;
  const ProfilePeer({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    void showImage(String photoUrl) async {
      await navigation.navigate(
        context,
        AppRoute.photoDetail.path,
        arguments: PhotoDetailArguments(
          photoUrl: photoUrl,
        ),
      );
    }

    Localization.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: renderHeaderClose(
        context: context,
        brightness: Theme.of(context).brightness,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 24, bottom: 8),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 88,
                    height: 88,
                    child: Material(
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: TextButton(
                        onPressed: () =>
                            showImage('https://picsum.photos/250?image=9'),
                        child: ClipOval(
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: 'res/icons/icMask.png',
                            image: 'https://picsum.photos/250?image=9',
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            EditTextBox(
              controller: TextEditingController(text: 'hello'),
              iconData: Icons.person_outline,
              margin: const EdgeInsets.only(top: 24.0),
              focusedColor: Theme.of(context).textTheme.displayLarge!.color,
              enabledColor: Theme.of(context).textTheme.displayMedium!.color,
              enabled: false,
              borderStyle: BorderStyle.none,
              borderWidth: 0,
            ),
            EditTextBox(
              iconData: Icons.email,
              margin: const EdgeInsets.only(top: 8.0),
              focusedColor: Theme.of(context).textTheme.displayLarge!.color,
              enabledColor: Theme.of(context).textTheme.displayMedium!.color,
              enabled: false,
              borderStyle: BorderStyle.none,
              borderWidth: 0,
            ),
            EditTextBox(
              iconData: Icons.phone,
              margin: const EdgeInsets.only(top: 8.0),
              focusedColor: Theme.of(context).textTheme.displayLarge!.color,
              enabledColor: Theme.of(context).textTheme.displayMedium!.color,
              enabled: false,
              borderStyle: BorderStyle.none,
              borderWidth: 0,
            ),
            Container(
              margin: const EdgeInsets.only(top: 32.0, bottom: 12.0),
              child: const Divider(
                height: 1.0,
              ),
            ),
            const EditTextBox(
              maxLines: 5,
              enabled: false,
              borderWidth: 0,
              borderStyle: BorderStyle.none,
            ),
          ],
        ),
      ),
    );
  }
}
