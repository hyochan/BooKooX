import 'package:bookoo2/models/User.dart';
import 'package:bookoo2/screens/photo_detail.dart';
import 'package:flutter/material.dart';

import 'package:bookoo2/shared/header.dart' show renderHeaderClose;
import 'package:bookoo2/shared/edit_text_box.dart' show EditTextBox;
import 'package:bookoo2/utils/general.dart';
import 'package:bookoo2/utils/localization.dart' show Localization;

class ProfilePeer extends StatefulWidget {
  final User user;

  ProfilePeer({
    @required this.user,
  });

  @override
  _ProfilePeerState createState() => _ProfilePeerState();
}

class _ProfilePeerState extends State<ProfilePeer> {
  void showImage(String photoUrl) async {

    var _result = await General.instance.navigateScreen(
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
    var _localization = Localization.of(context);

    return Scaffold(
      appBar: renderHeaderClose(
        context: context,
        brightness: Theme.of(context).brightness,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 24, bottom: 8),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 88,
                    height: 88,
                    child: Material(
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: FlatButton(
                        onPressed: () => showImage('https://picsum.photos/250?image=9'),
                        padding: EdgeInsets.all(0.0),
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
              margin: EdgeInsets.only(top: 24.0),
              focusedColor: Theme.of(context).textTheme.title.color,
              enabledColor: Theme.of(context).textTheme.subtitle.color,
              enabled: false,
              borderStyle: BorderStyle.none,
              borderWidth: 0,
            ),
            EditTextBox(
              iconData: Icons.email,
              margin: EdgeInsets.only(top: 8.0),
              focusedColor: Theme.of(context).textTheme.title.color,
              enabledColor: Theme.of(context).textTheme.subtitle.color,
              enabled: false,
              borderStyle: BorderStyle.none,
              borderWidth: 0,
            ),
            EditTextBox(
              iconData: Icons.phone,
              margin: EdgeInsets.only(top: 8.0),
              focusedColor: Theme.of(context).textTheme.title.color,
              enabledColor: Theme.of(context).textTheme.subtitle.color,
              enabled: false,
              borderStyle: BorderStyle.none,
              borderWidth: 0,
            ),
            Container(
              margin: EdgeInsets.only(top: 32.0, bottom: 12.0),
              child: Divider(
                height: 1.0,
              ),
            ),
            EditTextBox(
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
