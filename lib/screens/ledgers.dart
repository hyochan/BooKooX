import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:wecount/services/database.dart' show DatabaseService;
import 'package:wecount/utils/logger.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';
import 'package:wecount/widgets/header.dart' show renderHeaderClose;
import 'package:wecount/screens/ledger_edit.dart';
import 'package:wecount/screens/ledger_view.dart';
import 'package:wecount/widgets/profile_list_item.dart' show ProfileListItem;
import 'package:wecount/widgets/ledger_list_item.dart' show LedgerListItem;
import 'package:wecount/models/ledger.dart';
import 'package:wecount/utils/localization.dart';
import 'package:wecount/utils/asset.dart' as Asset;
import 'package:provider/provider.dart' show Provider;

class Ledgers extends HookWidget {
  const Ledgers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser!;
    var _localization = Localization.of(context)!;
    void onSettingPressed() {
      navigation.push(context, AppRoute.setting.path);
    }

    void onProfilePressed() {
      navigation.push(context, AppRoute.profileMy.path);
    }

    void onLedgerPressed(Ledger item) {
      Navigator.of(context).pop();
      DatabaseService().requestSelectLedger(item.id);
      Provider.of<CurrentLedger>(context, listen: false).setLedger(item);
    }

    void onLedgerMorePressed(Ledger item) {
      navigation.navigate(
        context,
        item.ownerId != user.uid
            ? AppRoute.ledgerView.path
            : AppRoute.ledgerEdit.path,
        arguments: item.ownerId != user.uid
            ? LedgerViewArguments(ledger: item)
            : LedgerEditArguments(ledger: item, mode: LedgerEditMode.UPDATE),
      );
    }

    void onAddLedgerPressed() {
      navigation.push(context, AppRoute.ledgerEdit.path);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                semanticLabel: _localization.trans('SETTING'),
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
                builder:
                    (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
                  if (!snapshot.hasData) return const SizedBox();

                  var profile = snapshot.data;
                  return ProfileListItem(
                    email: profile?.email ?? '',
                    displayName: profile?.displayName ?? '',
                    imgStr: profile?.thumbURL ?? profile?.photoURL,
                    onTap: onProfilePressed,
                  );
                }),
            StreamBuilder(
              stream: DatabaseService().streamLedgersWithMembership(user),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Ledger>> snapshot) {
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
                return const SizedBox();
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
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.add,
                      color: Asset.Colors.mediumGray,
                      size: 24.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        _localization.trans('ADD_LEDGER')!,
                        style: const TextStyle(
                          color: Asset.Colors.mediumGray,
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
