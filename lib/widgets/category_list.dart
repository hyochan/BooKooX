import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/widgets/category_item.dart';
import 'package:wecount/utils/db_helper.dart';
import 'package:wecount/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryList extends HookWidget {
  const CategoryList({
    super.key,
    required this.categories,
  });
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    var categories = useState<List<Category>>(this.categories);

    var localization = Localization.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Wrap(
          children: categories.value.map((Category category) {
            return CategoryItem(
              key: Key(category.id.toString()),
              category: category,
              onSelectPressed: () {
                Navigator.pop(context, category);
              },
              onDeletePressed: () {
                General.instance.showConfirmDialog(context,
                    title: Text(t('DELETE')),
                    content: Text(t('DELETE_ASK')), okPressed: () async {
                  try {
                    await DBHelper.instance
                        .deleteCategory(context, category.iconId);
                  } catch (err) {
                    Fluttertoast.showToast(
                      msg: t('CATEGORY_DELETE_ERROR'),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0,
                    );
                  } finally {
                    categories.value.remove(category);
                    Fluttertoast.showToast(
                      msg: t('CATEGORY_DELETED'),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0,
                    );
                  }

                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }, cancelPressed: () {
                  Navigator.of(context).pop();
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
