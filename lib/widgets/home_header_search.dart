import 'package:flutter/material.dart';

import 'package:wecount/widgets/edit_text_search.dart' show EditTextSearch;
import 'package:wecount/utils/localization.dart' show Localization;

class HomeHeaderSearch extends StatefulWidget {
  HomeHeaderSearch(
      {Key? key,
      this.margin,
      this.showSearchInput = false,
      this.textEditingController,
      this.onClose,
      this.onSubmit,
      this.color,
      required this.onPressAdd,
      required this.onPressDelete})
      : super(key: key);
  final EdgeInsets? margin;
  final bool showSearchInput;
  final TextEditingController? textEditingController;
  final Function? onClose;
  final Function? onSubmit;
  final Color? color;
  final Function onPressAdd;
  final Function onPressDelete;

  @override
  _HomeHeaderSearchState createState() => _HomeHeaderSearchState();
}

class _HomeHeaderSearchState extends State<HomeHeaderSearch> {
  var searchText = "";

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context)!;
    var textInput = EditTextSearch(
      controller: widget.textEditingController,
      textInputAction: TextInputAction.search,
      onChanged: (text) {
        setState(() {
          searchText = text;
        });
      },
      onSubmit: widget.onSubmit,
      background: Colors.transparent,
      txtHint: localization.trans('PLZ_SEARCH'),
      underline: false,
      txtHintStyle: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.5),
          fontWeight: FontWeight.w400,
          fontFamily: "AppleSDGothicNeo",
          fontStyle: FontStyle.normal,
          fontSize: 16.0),
      padding: EdgeInsets.only(left: 40.0, right: 44.0),
      borderRadius: 40.0,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      txtStyle: TextStyle(
          color: Colors.white,
          fontFamily: "AppleSDGothicNeo",
          fontStyle: FontStyle.normal,
          fontSize: 16.0),
      height: 40.0,
    );
    return Stack(children: [
      Container(margin: EdgeInsets.only(left: 20, right: 50), child: textInput),
      Positioned(
        child: Container(
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
          width: 16.0,
          height: 16.0,
        ),
        left: 32.0,
        top: 12.0,
      ),
      searchText != ""
          ? Positioned(
              child: Container(
                child: RawMaterialButton(
                  onPressed: () {
                    widget.onPressDelete();
                  },
                  shape: CircleBorder(),
                  child: Icon(Icons.close, color: Colors.white),
                  padding: EdgeInsets.all(0.0),
                ),
                width: 50.0,
              ),
              right: 0.0,
            )
          : Positioned(
              child: Container(
                width: 50.0,
                child: RawMaterialButton(
                  padding: EdgeInsets.all(0.0),
                  shape: CircleBorder(),
                  onPressed: () {
                    widget.onPressAdd();
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              right: 0.0,
            ),
    ]);
  }
}
