import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/asset.dart' as Asset;
import '../utils/general.dart';
import '../types/color.dart';
import '../widgets/header.dart' show renderHeaderClose;
import '../widgets/profile_list_item.dart' show ProfileListItem;
import '../widgets/ledger_list_item.dart' show LedgerListItem;

class MyLedgers extends StatefulWidget {
  MyLedgers({Key key}) : super(key: key);

  @override
  _MyLedgersState createState() => new _MyLedgersState();
}

class _MyLedgersState extends State<MyLedgers> {
  final List<ListItem> _items = [
    HeadingItem(
      'display', 'email', 'image'
    ),
    LedgerItem(
      'title', ColorType.BLUE, 4, false,
    ),
    LedgerItem(
      'title2', ColorType.BLUE, 4, true,
    ),
    LedgerItem(
      'title3', ColorType.BLUE, 1, false,
    ),
    LedgerItem(
      'title4', ColorType.BLUE, 4, false,
    ),
    LedgerItem(
      'titl5e', ColorType.BLUE, 8, false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    void onSettingPressed () {

    }

    void onLedgerMorePressed (LedgerItem item) {

    }

    void onAddLedgerPressed () {
      General.instance.navigateScreenNamed(context, '/ledger_add');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: renderHeaderClose(
        context: context,
        brightness: Brightness.light,
        title: Container(
          color: Colors.white,
        ),
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
                    );
                  } else if (item is LedgerItem) {
                    return LedgerListItem(
                      color: ColorType.BLUE,
                      title: item.title,
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
                        'Add Ledger',
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

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String displayName;
  final String email;
  final String imageString;

  HeadingItem(this.displayName, this.email, this.imageString);
}

class LedgerItem implements ListItem {
  final String title;
  final ColorType color;
  final int people;
  final bool isOwner;

  LedgerItem(this.title, this.color, this.people, this.isOwner);
}
