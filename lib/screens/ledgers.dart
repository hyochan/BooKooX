import 'package:get/get.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wecount/screens/profile_my.dart';
import 'package:wecount/screens/setting.dart';

import 'package:wecount/services/database.dart' show DatabaseService;
import 'package:wecount/shared/header.dart' show renderHeaderClose;
import 'package:wecount/screens/ledger_edit.dart';
import 'package:wecount/screens/ledger_view.dart';
import 'package:wecount/shared/profile_list_item.dart' show ProfileListItem;
import 'package:wecount/shared/ledger_list_item.dart' show LedgerListItem;
import 'package:wecount/models/ledger_model.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/localization.dart';
import 'package:wecount/utils/general.dart';
import 'package:provider/provider.dart' show Provider;

class Ledgers extends StatefulWidget {
  static const String name = '/ledgers';

  const Ledgers({Key? key}) : super(key: key);

  @override
  State<Ledgers> createState() => _LedgersState();
}

class _LedgersState extends State<Ledgers> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser!;
    void onSettingPressed() {
      General.instance.navigateScreenNamed(context, Setting.name);
    }

    void onProfilePressed() {
      General.instance.navigateScreenNamed(context, ProfileMy.name);
    }

    void onLedgerPressed(LedgerModel item) {
      Get.back();
      DatabaseService().requestSelectLedger(item.id);
      Provider.of<CurrentLedger>(context, listen: false).ledger = item;
    }

    void onLedgerMorePressed(LedgerModel item) {
      General.instance.navigateScreen(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => item.ownerId != user.uid
              ? LedgerView(ledger: item)
              : LedgerEdit(ledger: item, mode: LedgerEditMode.update),
        ),
      );
    }

    void onAddLedgerPressed() {
      General.instance.navigateScreenNamed(context, '/ledger_edit');
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderClose(
        context: context,
        brightness: Theme.of(context).brightness,
        actions: [
          SizedBox(
            width: 56.0,
            child: RawMaterialButton(
              padding: const EdgeInsets.all(0.0),
              shape: const CircleBorder(),
              onPressed: onSettingPressed,
              child: Icon(
                Icons.settings,
                color: Theme.of(context).iconTheme.color,
                semanticLabel: t('SETTING'),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StreamBuilder(
                stream: DatabaseService().streamUser(user.uid),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) return Container();

                  var profile = snapshot.data;

                  return ProfileListItem(
                    email: profile.email ?? '',
                    displayName: profile.displayName ?? '',
                    imgStr: profile.thumbURL ?? profile.photoURL,
                    onTap: onProfilePressed,
                  );
                }),
            StreamBuilder(
              stream: DatabaseService().streamLedgersWithMembership(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<LedgerModel>> snapshot) {
                if (snapshot.data != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];

                        return LedgerListItem(
                          title: item.title,
                          color: item.color,
                          people: item.people,
                          isOwner: item.ownerId == user.uid,
                          onMorePressed: () => onLedgerMorePressed(item),
                          onLedgerPressed: () => onLedgerPressed(item),
                        );
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
            const Divider(
              color: Color.fromARGB(255, 220, 226, 235),
              height: 1,
            ),
            SizedBox(
              height: 68.0,
              child: TextButton(
                onPressed: onAddLedgerPressed,
                // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.add,
                      color: mediumGrayColor,
                      size: 24.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        t('ADD_LEDGER'),
                        style: const TextStyle(
                          color: mediumGrayColor,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
