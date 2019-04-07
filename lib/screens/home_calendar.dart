import 'package:flutter/material.dart';

import '../widgets/edit_text.dart' show EditText;
import '../widgets/button.dart' show Button;

import '../utils/localization.dart' show Localization;
import '../utils/theme.dart' as Theme;

class HomeCalendar extends StatefulWidget {
  HomeCalendar({Key key}) : super(key: key);

  @override
  _HomeCalendarState createState() => new _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  ScrollController _scrollController;
  EdgeInsets _titlePadding = EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
//        if (_scrollController.offset > 52.0) {
//          setState(() {
//            _titlePadding = null;
//          });
//        } else {
//          setState(() {
//            _titlePadding = EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);
//          });
//        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  titlePadding: _titlePadding,
                  title: Text("Dream Worker",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  background: Container(
                    color: Theme.Colors.dusk,
                  ),
              ),
            ),
          ];
        },
        controller: _scrollController,
        body: Center(
          child: Text("Sample Text"),
        ),
      ),
    );
  }
}
