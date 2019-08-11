import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;


import '../widgets/home_header.dart' show HomeHeaderExpanded;
import '../widgets/edit_text.dart' show EditText;
import '../widgets/button.dart' show Button;

import '../utils/localization.dart' show Localization;
import '../utils/theme.dart' as Theme;

class HomeCalendar extends StatefulWidget {
  HomeCalendar({
    Key key,
    this.title = '',
  }) : super(key: key);
  final String title;

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
            HomeHeaderExpanded(
              title: widget.title,
              actions: [
                Container(
                  width: 56.0,
                  child: RawMaterialButton(
                    padding: EdgeInsets.all(0.0),
                    shape: CircleBorder(),
                    onPressed: () { },
                    child: Icon(
                      Icons.book,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: 56.0,
                  child: RawMaterialButton(
                    padding: EdgeInsets.all(0.0),
                    shape: CircleBorder(),
                    onPressed: () { },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]
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
