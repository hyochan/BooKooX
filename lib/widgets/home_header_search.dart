import 'package:flutter/material.dart';

import '../widgets//text_input.dart' show TextInput;
import '../utils/theme.dart' as Theme;

class HomeHeaderSearch extends StatefulWidget {
  HomeHeaderSearch({
    Key key,
    this.showSearchInput = false,
    this.title = '',
    this.onChangedSearchText,
    this.onSubmitSearchText,
  }) : super(key: key);
  final bool showSearchInput;
  final String title;
  final Function onChangedSearchText;
  final Function onSubmitSearchText;

  @override
  _HomeHeaderSearchState createState() => new _HomeHeaderSearchState();
}

class _HomeHeaderSearchState extends State<HomeHeaderSearch> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      titleSpacing: 0.0,
      actions: <Widget>[
        Icon(Icons.add),
      ],
      title: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          TextInput(
            margin: EdgeInsets.only(right: 20.0),
            textInputAction: TextInputAction.search,
            onChanged: widget.onChangedSearchText,
            onSubmit: widget.onSubmitSearchText,
            background: Colors.transparent,
            txtHint: 'hint',
            underline: false,
            txtHintStyle: TextStyle(
                color:  Color.fromRGBO(255, 255, 255, 0.5),
                fontWeight: FontWeight.w400,
                fontFamily: "AppleSDGothicNeo",
                fontStyle:  FontStyle.normal,
                fontSize: 16.0
            ),
            padding: EdgeInsets.only(left: 40.0, right: 8.0),
            borderRadius: 40.0,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            txtStyle: TextStyle(
                color: Colors.white,
                fontFamily: "AppleSDGothicNeo",
                fontStyle:  FontStyle.normal,
                fontSize: 16.0
            ),
            height: 40.0,
          ),
          Positioned(
            child: Container(
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
              width: 16.0,
              height: 16.0,
            ),
            left: 12.0,
            top: 10.0,
          ),
          Positioned(
            child: Container(
              child: RawMaterialButton(
                onPressed: () {},
                child: Icon(
                    Icons.close,
                    color: Colors.white
                ),
                padding: EdgeInsets.all(0.0),
              ),
              width: 40.0,
              height: 40.0,
            ),
            right: 24.0,
          ),
        ],
      ),
    );
  }
}
