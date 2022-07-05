import 'package:wecount/models/user_model.dart';
import 'package:wecount/screens/photo_detail.dart';
import 'package:flutter/material.dart';

import 'package:wecount/shared/header.dart' show renderHeaderClose;
import 'package:wecount/shared/edit_text_box.dart' show EditTextBox;
import 'package:wecount/utils/general.dart';

class ProfilePeer extends StatefulWidget {
  final UserModel user;

  const ProfilePeer({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfilePeer> createState() => _ProfilePeerState();
}

class _ProfilePeerState extends State<ProfilePeer> {
  void showImage(String photoUrl) async {
    await General.instance.navigateScreen(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => PhotoDetail(
          photoUrl: photoUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () =>
                            showImage('https://picsum.photos/250?image=9'),
                        padding: const EdgeInsets.all(0.0),
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
              focusedColor: Theme.of(context).textTheme.headline1!.color,
              enabledColor: Theme.of(context).textTheme.headline2!.color,
              enabled: false,
              borderStyle: BorderStyle.none,
              borderWidth: 0,
            ),
            EditTextBox(
              iconData: Icons.email,
              margin: const EdgeInsets.only(top: 8.0),
              focusedColor: Theme.of(context).textTheme.headline1!.color,
              enabledColor: Theme.of(context).textTheme.headline2!.color,
              enabled: false,
              borderStyle: BorderStyle.none,
              borderWidth: 0,
            ),
            EditTextBox(
              iconData: Icons.phone,
              margin: const EdgeInsets.only(top: 8.0),
              focusedColor: Theme.of(context).textTheme.headline1!.color,
              enabledColor: Theme.of(context).textTheme.headline2!.color,
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
