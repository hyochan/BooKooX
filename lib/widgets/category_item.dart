import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/models/category.dart';
import 'package:flutter/material.dart';

class CategoryItem extends HookWidget {
  CategoryItem({
    this.key,
    required this.category,
    this.onSelectPressed,
    this.onDeletePressed,
  });
  final Key? key;
  final Category category;
  final Function? onDeletePressed;
  final Function? onSelectPressed;

  @override
  Widget build(BuildContext context) {
    var category = useState<Category>(this.category);

    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 8),
      child: InkWell(
        onTap: () {
          onSelectPressed!();
        },
        onLongPress: () =>
            category.value.showDelete = !category.value.showDelete,
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
                  margin: EdgeInsets.only(top: 8),
                  width: 80,
                  child: AutoSizeText(
                    category.value.label ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.displayLarge!.color,
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
                      padding: EdgeInsets.all(2),
                      child: InkWell(
                        onTap: onDeletePressed as void Function()?,
                        child: ClipOval(
                          child: Container(
                            width: 24,
                            height: 24,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                            child: Icon(
                              Icons.close,
                              color: Theme.of(context).colorScheme.background,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}