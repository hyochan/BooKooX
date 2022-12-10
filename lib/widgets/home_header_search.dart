import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:wecount/widgets/edit_text_search.dart' show EditTextSearch;
import 'package:wecount/utils/localization.dart' show Localization;

class HomeHeaderSearch extends HookWidget {
  const HomeHeaderSearch(
      {Key? key,
      this.showSearchInput = false,
      this.textEditingController,
      this.onClose,
      this.onSubmit,
      required this.onPressAdd,
      required this.onPressDelete})
      : super(key: key);
  final bool showSearchInput;
  final TextEditingController? textEditingController;
  final Function? onClose;
  final Function? onSubmit;
  final Function onPressAdd;
  final Function onPressDelete;

  @override
  Widget build(BuildContext context) {
    var searchText = useState<String>("");

    var localization = Localization.of(context)!;
    var textInput = EditTextSearch(
      controller: textEditingController,
      textInputAction: TextInputAction.search,
      onChanged: (text) {
        searchText.value = text;
      },
      onSubmit: onSubmit,
      background: Colors.transparent,
      txtHint: localization.trans('PLZ_SEARCH'),
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
    return Stack(children: [
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 20), child: textInput),
      const Positioned(
        left: 32.0,
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
      searchText.value != ""
          ? Positioned(
              right: 17.0,
              child: SizedBox(
                width: 50.0,
                child: RawMaterialButton(
                  onPressed: () {
                    onPressDelete();
                    searchText.value = "";
                  },
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(0.0),
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            )
          : Positioned(
              right: 17.0,
              child: SizedBox(
                width: 50.0,
                child: RawMaterialButton(
                  padding: const EdgeInsets.all(0.0),
                  shape: const CircleBorder(),
                  onPressed: () => onPressAdd(),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
    ]);
  }
}
