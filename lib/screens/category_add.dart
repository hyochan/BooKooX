import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wecount/models/category_model.dart';
import 'package:wecount/shared/edit_text_box.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/db_helper.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/localization.dart';

class CategoryAdd extends StatefulWidget {
  final CategoryType categoryType;
  final int? lastId;
  const CategoryAdd({
    Key? key,
    this.categoryType = CategoryType.consume,
    required this.lastId,
  }) : super(key: key);

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  int? _selectedIconIndex;
  final TextEditingController _textController = TextEditingController();
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    void onDonePressed() async {
      if (_textController.text == '') {
        setState(() {
          _errorText = t('ERROR_CATEGORY_NAME');
        });
        return;
      }
      if (_selectedIconIndex == null) {
        General.instance.showSingleDialog(
          context,
          title: Text(t('ERROR')),
          content: Text(t('ERROR_CATEGORY_ICON')),
        );
        return;
      }
      Category category = Category(
        id: widget.lastId! + 1,
        iconId: _selectedIconIndex,
        label: _textController.text,
        type: widget.categoryType,
      );

      try {
        await DBHelper.instance.insertCategory(context, category);
      } catch (err) {
        Fluttertoast.showToast(
          msg: t('CATEGORY_ADD_ERROR'),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0,
        );
      } finally {
        Navigator.pop(context, category);
      }
    }

    void onCancelPressed() {
      Navigator.of(context).pop();
    }

    Widget renderIcons() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: SingleChildScrollView(
          child: Center(
            child: Wrap(
              children: categoryIcons
                  .asMap()
                  .map(
                    (int i, AssetImage icon) {
                      return MapEntry(
                        i,
                        Container(
                          padding: const EdgeInsets.only(left: 8, bottom: 8),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedIconIndex = i;
                              });
                            },
                            child: Opacity(
                              opacity: i == _selectedIconIndex ? 1.0 : 0.4,
                              child: Image(
                                image: icon,
                                width: 72,
                                height: 72,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                  .values
                  .toList(),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 40,
                      bottom: 24,
                    ),
                    child: Text(
                      t('CATEGORY_ADD'),
                      style: TextStyle(
                        fontSize: 28,
                        color: Theme.of(context).textTheme.headline1!.color,
                      ),
                    ),
                  ),
                  EditTextBox(
                    controller: _textController,
                    margin: const EdgeInsets.only(
                      bottom: 16,
                      left: 24,
                      right: 24,
                    ),
                    hintText: t('CATEGORY_ADD_HINT'),
                    errorText: _errorText,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                          left: 24,
                          right: 8,
                        ),
                        child: const Icon(
                          Icons.star,
                          size: 20,
                          color: mediumGrayColor,
                        ),
                      ),
                      Text(
                        t('ICON_SELECT'),
                        style: const TextStyle(
                          color: mediumGrayColor,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  Expanded(child: renderIcons()),
                ],
              ),
            ),
            Container(
              height: 68,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: onCancelPressed,
                      child: Text(
                        t('CANCEL'),
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: onDonePressed,
                      child: Text(
                        t('DONE'),
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
