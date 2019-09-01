import 'package:flutter/material.dart';
import '../shared/edit_text_search.dart' show EditTextSearch;

class HomeHeaderSearch extends StatefulWidget {
  HomeHeaderSearch({
    Key key,
    this.margin,
    this.showSearchInput = false,
    this.textEditingController,
    this.actions,
    this.onClose,
    this.onSubmit,
  }) : super(key: key);
  final EdgeInsets margin;
  final bool showSearchInput;
  final TextEditingController textEditingController;
  final List<Widget> actions;
  final Function onClose;
  final Function onSubmit;

  @override
  _HomeHeaderSearchState createState() => new _HomeHeaderSearchState();
}

class _HomeHeaderSearchState extends State<HomeHeaderSearch> {
  bool _showClose = false;

  @override
  Widget build(BuildContext context) {
    var textInput = EditTextSearch(
      controller: widget.textEditingController,
      textInputAction: TextInputAction.search,
      onChanged: (text) {
        if (text == '') {
          setState(() {
            _showClose = false;
          });
        } else {
          setState(() {
            _showClose = true;
          });
        }
      },
      onSubmit: widget.onSubmit,
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
      padding: EdgeInsets.only(left: 40.0, right: 44.0),
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
    );
    return AppBar(
      elevation: 0.0,
      titleSpacing: 0.0,
      actions: widget.actions,
      title: Container(
        margin: widget.margin,
        child: Stack(
          children: <Widget>[
            textInput,
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
            _showClose == true
            ? Positioned(
              child: Container(
                child: RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      widget.textEditingController.clear();
                      _showClose = false;
                    });
                  },
                  shape: CircleBorder(),
                  child: Icon(
                      Icons.close,
                      color: Colors.white
                  ),
                  padding: EdgeInsets.all(0.0),
                ),
                width: 40.0,
                height: 40.0,
              ),
              right: 8.0,
            ) : Container(height: 40.0),
          ],
        ),
      ),
    );
  }
}
