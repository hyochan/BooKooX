import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wecount/models/category_model.dart';
import 'package:wecount/shared/category_item.dart';
import 'package:wecount/utils/db_helper.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/localization.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key? key,
    required this.categories,
  }) : super(key: key);
  final List<Category> categories;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late List<Category> _categories;

  @override
  void initState() {
    _categories = widget.categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Wrap(
          children: _categories.map((Category category) {
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
                    setState(() {
                      _categories.remove(category);
                    });
                    Fluttertoast.showToast(
                      msg: t('CATEGORY_DELETED'),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0,
                    );
                  }
                  Get.back();
                }, cancelPressed: () {
                  Get.back();
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
