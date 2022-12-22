import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/models/ledger_item_model.dart';
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
  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    var categories = useState<List<CategoryModel>>(this.categories);

    return SafeArea(
      child: SingleChildScrollView(
        child: Wrap(
          children: categories.value.map((CategoryModel category) {
            return CategoryItem(
              key: Key(category.id.toString()),
              category: category,
              onSelectPressed: () {
                Navigator.pop(context, category);
              },
              onDeletePressed: () {
                General.instance.showConfirmDialog(context,
                    title: Text(localization(context).delete),
                    content: Text(localization(context).deleteAsk),
                    okPressed: () async {
                  try {
                    await DBHelper.instance
                        .deleteCategory(context, category.iconId);
                  } catch (err) {
                    Fluttertoast.showToast(
                      msg: localization(context).categoryDeleteError,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0,
                    );
                  } finally {
                    categories.value.remove(category);
                    Fluttertoast.showToast(
                      msg: localization(context).categoryDeleted,
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
