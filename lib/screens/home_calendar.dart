import 'package:flutter/material.dart';
import '../utils/general.dart';
import '../shared/home_header.dart' show HomeHeaderExpanded;

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
                      color: Theme.of(context).textTheme.title.color,
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
                      color: Theme.of(context).textTheme.title.color,
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
