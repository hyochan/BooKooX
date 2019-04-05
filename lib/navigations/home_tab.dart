import 'package:flutter/material.dart';

import '../screens/my_drawer.dart' show MyDrawer;
import '../utils/localization.dart' show Localization;

class HomeTab extends StatefulWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  _HomeTabState createState() => new _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  TabController _tabController;
  int _index = 0;
  var _localization;

  @override
  Widget build(BuildContext context) {
    _localization = Localization.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: MyDrawer(
          onClose: () => Navigator.of(context).pop(),
          onSetting: () => Navigator.of(context).pop(),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 136.0,
              floating: false,
              pinned: true,
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(Icons.add),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text("Dream Worker",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                background: Container(
                  color: Colors.blue,
                ),
              ),
            ),
          ];
        },
        body: Stack(
          children: <Widget>[
            Offstage(
              offstage: _index != 0,
              child: TickerMode(
                enabled: _index == 0,
                child: Icon(Icons.directions_car),
              ),
            ),
            Offstage(
              offstage: _index != 1,
              child: TickerMode(
                enabled: _index == 1,
                child: Icon(Icons.ac_unit),
              ),
            ),
            Offstage(
              offstage: _index != 2,
              child: TickerMode(
                enabled: _index == 2,
                child: Icon(Icons.accessible),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        onTap: (int index) { setState((){ this._index = index; }); },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Container(child:
            Text('Message'),
              margin: EdgeInsets.only(top: 4.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Container(child:
            Text('Favorite'),
              margin: EdgeInsets.only(top: 4.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Container(child:
            Text('Setting'),
              margin: EdgeInsets.only(top: 4.0),
            ),
          ),
        ],
      ),
    );
  }
}
