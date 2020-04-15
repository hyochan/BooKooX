import 'package:bookoox/models/Currency.dart';
import 'package:flutter/material.dart';

import 'package:bookoox/shared/header.dart' show renderHeaderClose;
import 'package:bookoox/screens/ledger_add.dart';
import 'package:bookoox/screens/ledger_view.dart';
import 'package:bookoox/shared/profile_list_item.dart' show ProfileListItem;
import 'package:bookoox/shared/ledger_list_item.dart' show LedgerListItem, HeadingItem, LedgerItem, ListItem;
import 'package:bookoox/models/Ledger.dart';
import 'package:bookoox/utils/localization.dart';
import 'package:bookoox/utils/asset.dart' as Asset;
import 'package:bookoox/utils/general.dart';
import 'package:bookoox/types/color.dart';

class Ledgers extends StatefulWidget {
  Ledgers({Key key}) : super(key: key);

  @override
  _LedgersState createState() => new _LedgersState();
}

class _LedgersState extends State<Ledgers> {
  final List<ListItem> _fakeLedgers = [
    HeadingItem(
      'display', 'email', 'image'
    ),
    LedgerItem(
      Ledger(
        title: 'title',
        color: ColorType.ORANGE,
        people: 4,
        currency: Currency(
          code: '\$',
          currency: 'USD',
        ),
      ),
      true,
    ),
    LedgerItem(
      Ledger(
        title: 'title2',
        color: ColorType.BLUE,
        people: 4,
        currency: Currency(
          code: '\$',
          currency: 'USD',
        ),
      ),
      false,
    ),
    LedgerItem(
      Ledger(
        title: 'title3',
        color: ColorType.RED,
        people: 1,
        currency: Currency(
          code: '\$',
          currency: 'USD',
        ),
      ),
      false,
    ),
    LedgerItem(
      Ledger(
        title: 'title4',
        color: ColorType.DUSK,
        people: 4,
        currency: Currency(
          code: '\$',
          currency: 'USD',
        ),
      ),
      false,
    ),
    LedgerItem(
      Ledger(
        title: 'title5',
        color: ColorType.GREEN,
        people: 8,
        currency: Currency(
          code: '\$',
          currency: 'USD',
        ),
      ),
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);
    void onSettingPressed () {
      General.instance.navigateScreenNamed(context, '/setting');
    }

    void onProfilePressed () {
      General.instance.navigateScreenNamed(context, '/profile_my');
    }

    void onLedgerMorePressed (LedgerItem item) {
      General.instance.navigateScreen(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => !item.isOwner
            ? LedgerView(ledger: item.ledger)
            : LedgerAdd(ledger: item.ledger),
        ),
      );
    }

    void onAddLedgerPressed () {
      General.instance.navigateScreenNamed(context, '/ledger_add');
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
            Expanded(
              child: ListView.builder(
                itemCount: _fakeLedgers.length,
                itemBuilder: (context, index) {
                  final item = _fakeLedgers[index];
                  if (item is HeadingItem) {
                    return ProfileListItem(
                      email: item.email,
                      displayName: item.displayName,
                      imageString: item.imageString,
                      onTap: onProfilePressed,
                    );
                  } else if (item is LedgerItem) {
                    return LedgerListItem(
                      title: item.ledger.title,
                      color: item.ledger.color,
                      people: item.ledger.people,
                      isOwner: item.isOwner,
                      onMorePressed: () => onLedgerMorePressed(item),
                    );
                  }
                  return null;
                },
              ),
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
