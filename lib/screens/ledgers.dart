import 'package:bookoox/models/Currency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:bookoox/services/database.dart' show DatabaseService;
import 'package:bookoox/shared/header.dart' show renderHeaderClose;
import 'package:bookoox/screens/ledger_edit.dart';
import 'package:bookoox/screens/ledger_view.dart';
import 'package:bookoox/shared/profile_list_item.dart' show ProfileListItem;
import 'package:bookoox/shared/ledger_list_item.dart' show LedgerListItem, HeadingItem, LedgerItem, ListItem;
import 'package:bookoox/models/Ledger.dart';
import 'package:bookoox/utils/localization.dart';
import 'package:bookoox/utils/asset.dart' as Asset;
import 'package:bookoox/utils/general.dart';
import 'package:bookoox/types/color.dart';
import 'package:provider/provider.dart' show Provider;

class Ledgers extends StatefulWidget {
  Ledgers({Key key}) : super(key: key);

  @override
  _LedgersState createState() => new _LedgersState();
}

class _LedgersState extends State<Ledgers> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    var _localization = Localization.of(context);
    void onSettingPressed () {
      General.instance.navigateScreenNamed(context, '/setting');
    }

    void onProfilePressed () {
      General.instance.navigateScreenNamed(context, '/profile_my');
    }

    void onLedgerMorePressed (Ledger item) {
      General.instance.navigateScreen(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => item.ownerId != user.uid
            ? LedgerView(ledger: item)
            : LedgerEdit(ledger: item, mode: LedgerEditMode.UPDATE),
        ),
      );
    }

    void onAddLedgerPressed () {
      General.instance.navigateScreenNamed(context, '/ledger_edit');
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderClose(
        context: context,
        brightness: Theme.of(context).brightness,
        actions: [
          Container(
            width: 56.0,
            child: RawMaterialButton(
              padding: EdgeInsets.all(0.0),
              shape: CircleBorder(),
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
            ProfileListItem(
              email: user.email ?? '',
              displayName: user.displayName ?? '',
              imageString: user.photoUrl ?? '',
              onTap: onProfilePressed,
            ),
            StreamBuilder(
              stream: DatabaseService().streamLedgersWithMembership(user),
              builder: (BuildContext context, AsyncSnapshot<List<Ledger>> snapshot) {
                if (snapshot.data != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data[index];

                        return LedgerListItem(
                          title: item.title ?? '',
                          color: item.color,
                          people: item.people,
                          isOwner: item.ownerId == user.uid ?? false,
                          onMorePressed: () => onLedgerMorePressed(item),
                        );
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
            Divider(
              color: Color.fromARGB(255, 220, 226, 235),
              height: 1,
            ),
            Container(
              height: 68.0,
              child: FlatButton(
                onPressed: onAddLedgerPressed,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Asset.Colors.mediumGray,
                      size: 24.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        _localization.trans('ADD_LEDGER'),
                        style: TextStyle(
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
