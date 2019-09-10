import 'package:bookoo2/models/Category.dart';
import 'package:bookoo2/shared/category_item.dart';
import 'package:bookoo2/utils/db_helper.dart';
import 'package:bookoo2/utils/general.dart';
import 'package:bookoo2/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryList extends StatefulWidget {
  CategoryList({
    @required this.categories,
  });
  final List<Category> categories;

  @override
  _CategoryListState createState() => _CategoryListState(categories);
}

class _CategoryListState extends State<CategoryList> {
  List<Category> categories;
  _CategoryListState(this.categories);

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);
    return Container(
      child: SingleChildScrollView(
        child: Wrap(
          children: categories.map((Category category) {
            return CategoryItem(
              key: Key(category.iconId.toString()),
              category: category,
              onDeletePressed: () {
                General.instance.showConfirmDialog(
                  context,
                  title: _localization.trans('DELETE'),
                  content: _localization.trans('DELETE_ASK'),
                  okPressed: () async {
                    try {
                      await DbHelper.instance.deleteCategory(context, category.iconId);
                    } catch (err) {
                      Fluttertoast.showToast(
                        msg: _localization.trans('CATEGORY_DELETE_ERROR'),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        fontSize: 16.0,
                      );
                    } finally {
                      this.setState(() {
                        categories.remove(category);
                      });
                      Fluttertoast.showToast(
                        msg: _localization.trans('CATEGORY_DELETED'),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        fontSize: 16.0,
                      );
                    }
                    Navigator.of(context).pop();
                  },
                  cancelPressed: () {
                    Navigator.of(context).pop();
                  }
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}