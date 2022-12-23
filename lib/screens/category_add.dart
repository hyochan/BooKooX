import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wecount/models/ledger_item_model.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/db_helper.dart';
import 'package:wecount/utils/localization.dart';
import 'package:wecount/widgets/common/edit_text.dart';

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
        errorText.value = localization(context).errorCategoryName;
        return;
      }

      CategoryModel category = CategoryModel(
        id: lastId! + 1,
        iconId: selectedIconIndex.value,
        label: textController.text,
        type: categoryType,
      );

      try {
        await DBHelper.instance.insertCategory(context, category);
      } catch (err) {
        Fluttertoast.showToast(
          msg: localization(context).categoryAddError,
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
                      localization(context).categoryAdd,
                      style: TextStyle(
                        fontSize: 28,
                        color: AppColors.text.basic,
                      ),
                    ),
                  ),
                  EditText(
                    textEditingController: textController,
                    margin: const EdgeInsets.only(
                      bottom: 16,
                      left: 24,
                      right: 24,
                    ),
                    textHint: localization(context).categoryAddHint,
                    errorText: errorText.value,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                          left: 24,
                          right: 8,
                        ),
                        child: Icon(
                          Icons.star,
                          size: 20,
                          color: AppColors.text.secondary,
                        ),
                      ),
                      Text(
                        localization(context).iconSelect,
                        style: TextStyle(
                            color: AppColors.text.secondary, fontSize: 16),
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
                        localization(context).cancel,
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.text.basic,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      onPressed: onDonePressed,
                      child: Text(
                        localization(context).done,
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.text.basic,
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
