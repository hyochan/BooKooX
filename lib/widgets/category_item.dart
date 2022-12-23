import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:wecount/models/ledger_item_model.dart';
import 'package:wecount/utils/colors.dart';

class CategoryItem extends HookWidget {
  const CategoryItem({
    super.key,
    required this.category,
    this.onSelectPressed,
    this.onDeletePressed,
  });
  final CategoryModel category;
  final Function? onDeletePressed;
  final Function? onSelectPressed;

  @override
  Widget build(BuildContext context) {
    var category = useState<CategoryModel>(this.category);

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 8),
      child: InkWell(
        onTap: () {
          onSelectPressed!();
        },
        onLongPress: () => category.value =
            category.value.copyWith(showDelete: !category.value.showDelete),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Image(
                  image: category.value.getIconImage()!,
                  width: 72,
                  height: 72,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 80,
                  child: AutoSizeText(
                    category.value.label,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.text.basic,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                )
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: category.value.showDelete
                  ? Container(
                      padding: const EdgeInsets.all(2),
                      child: InkWell(
                        onTap: onDeletePressed as void Function()?,
                        child: ClipOval(
                          child: Container(
                            width: 24,
                            height: 24,
                            color: AppColors.text.basic,
                            child: Icon(
                              Icons.close,
                              color: AppColors.bg.basic,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
