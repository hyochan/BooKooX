import 'package:flutter/material.dart';

import 'package:bookoo2/utils/general.dart';
import 'package:bookoo2/shared/home_header.dart' show HomeHeaderExpanded;

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
      backgroundColor: Theme.of(context).backgroundColor,
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
                    onPressed: () => General.instance.navigateScreenNamed(context, '/ledgers'),
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
                    onPressed: () => General.instance.navigateScreenNamed(context, '/ledger_item_add'),
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
