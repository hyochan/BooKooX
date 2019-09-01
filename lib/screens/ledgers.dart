import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/localization.dart';
import '../utils/asset.dart' as Asset;
import '../utils/general.dart';
import '../types/color.dart';
import '../shared/header.dart' show renderHeaderClose;
import '../shared/profile_list_item.dart' show ProfileListItem;
import '../shared/ledger_list_item.dart' show LedgerListItem, HeadingItem, LedgerItem, ListItem;

class Ledgers extends StatefulWidget {
  Ledgers({Key key}) : super(key: key);

  @override
  _LedgersState createState() => new _LedgersState();
}

class _LedgersState extends State<Ledgers> {
  final List<ListItem> _items = [
    HeadingItem(
      'display', 'email', 'image'
    ),
    LedgerItem(
      'title', ColorType.ORANGE, 4, false,
    ),
    LedgerItem(
      'title2', ColorType.BLUE, 4, true,
    ),
    LedgerItem(
      'title3', ColorType.RED, 1, false,
    ),
    LedgerItem(
      'title4', ColorType.DUSK, 4, false,
    ),
    LedgerItem(
      'titl5e', ColorType.GREEN, 8, false,
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

    }

    void onAddLedgerPressed () {
      General.instance.navigateScreenNamed(context, '/ledger_add');
    }

    return Scaffold(
      appBar: renderHeaderClose(
        context: context,
        brightness: Brightness.light,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              semanticLabel: 'setting',
            ),
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(0.0),
            onPressed: onSettingPressed,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];

                  if (item is HeadingItem) {
                    return ProfileListItem(
                      email: item.email,
                      displayName: item.displayName,
                      imageString: item.imageString,
                      onTap: onProfilePressed,
                    );
                  } else if (item is LedgerItem) {
                    return LedgerListItem(
                      title: item.title,
                      color: item.color,
                      people: item.people,
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
            ),
            Container(
              height: 60.0,
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: FlatButton(
                onPressed: onAddLedgerPressed,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Asset.Colors.mediumGray,
                      size: 24.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0),
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
