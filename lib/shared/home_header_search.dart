import 'package:flutter/material.dart';

import 'package:wecount/shared/edit_text_search.dart' show EditTextSearch;

import '../utils/localization.dart';

class HomeHeaderSearch extends StatefulWidget {
  const HomeHeaderSearch({
    Key? key,
    this.margin,
    this.showSearchInput = false,
    this.textEditingController,
    this.actions,
    this.onSubmit,
    this.color,
  }) : super(key: key);
  final EdgeInsets? margin;
  final bool showSearchInput;
  final TextEditingController? textEditingController;
  final List<Widget>? actions;
  final Function(String)? onSubmit;
  final Color? color;

  @override
  State<HomeHeaderSearch> createState() => _HomeHeaderSearchState();
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
      txtHint: t('PLZ_SEARCH'),
      underline: false,
      txtHintStyle: const TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.5),
          fontWeight: FontWeight.w400,
          fontFamily: "AppleSDGothicNeo",
          fontStyle: FontStyle.normal,
          fontSize: 16.0),
      padding: const EdgeInsets.only(left: 40.0, right: 44.0),
      borderRadius: 40.0,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      txtStyle: const TextStyle(
          color: Colors.white,
          fontFamily: "AppleSDGothicNeo",
          fontStyle: FontStyle.normal,
          fontSize: 16.0),
      height: 40.0,
    );
    return AppBar(
      elevation: 0.0,
      titleSpacing: 0.0,
      backgroundColor: widget.color,
      actions: widget.actions,
      title: Container(
        margin: widget.margin,
        child: Stack(
          children: <Widget>[
            textInput,
            const Positioned(
              left: 12.0,
              top: 12.0,
              child: SizedBox(
                width: 16.0,
                height: 16.0,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
            _showClose == true
                ? Positioned(
                    right: 8.0,
                    child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: RawMaterialButton(
                        onPressed: () {
                          setState(() {
                            widget.textEditingController!.clear();
                            _showClose = false;
                          });
                        },
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(0.0),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  )
                : Container(height: 40.0),
          ],
        ),
      ),
    );
  }
}
