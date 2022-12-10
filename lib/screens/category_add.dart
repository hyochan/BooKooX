import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/widgets/edit_text_box.dart';
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/db_helper.dart';
import 'package:wecount/utils/localization.dart';

class CategoryAdd extends HookWidget {
  final CategoryType categoryType;
  final int? lastId;
  const CategoryAdd({
    Key? key,
    this.categoryType = CategoryType.consume,
    required this.lastId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    var selectedIconIndex = useState<int?>(0);
    var errorText = useState<String?>('');

    void onDonePressed() async {
      if (textController.text == '') {
        errorText.value = t('ERROR_CATEGORY_NAME');
        return;
      }

      Category category = Category(
        id: lastId! + 1,
        iconId: selectedIconIndex.value,
        label: textController.text,
        type: categoryType,
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
                              selectedIconIndex.value = i;
                            },
                            child: Opacity(
                              opacity: i == selectedIconIndex.value ? 1.0 : 0.4,
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
                        color: Theme.of(context).textTheme.displayLarge!.color,
                      ),
                    ),
                  ),
                  EditTextBox(
                    controller: textController,
                    margin: const EdgeInsets.only(
                      bottom: 16,
                      left: 24,
                      right: 24,
                    ),
                    hintText: t('CATEGORY_ADD_HINT'),
                    errorText: errorText.value,
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
                          color: asset.Colors.mediumGray,
                        ),
                      ),
                      Text(
                        t('ICON_SELECT'),
                        style: const TextStyle(
                          color: asset.Colors.mediumGray,
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
                    child: TextButton(
                      onPressed: onCancelPressed,
                      child: Text(
                        t('CANCEL'),
                        style: TextStyle(
                          fontSize: 20,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      onPressed: onDonePressed,
                      child: Text(
                        t('DONE'),
                        style: TextStyle(
                          fontSize: 20,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
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
