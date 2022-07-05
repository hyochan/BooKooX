import 'package:auto_size_text/auto_size_text.dart';
import 'package:wecount/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({
    Key? key,
    required this.category,
    this.onSelectPressed,
    this.onDeletePressed,
  }) : super(key: key);

  final Category category;
  final Function? onDeletePressed;
  final Function? onSelectPressed;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  late Category _category;

  @override
  void initState() {
    _category = widget.category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 8),
      child: InkWell(
        onTap: () {
          widget.onSelectPressed!();
        },
        onLongPress: () => setState(() {
          _category.showDelete = !_category.showDelete;
        }),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Image(
                  image: _category.getIconImage()!,
                  width: 72,
                  height: 72,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 80,
                  child: AutoSizeText(
                    _category.label ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.headline1!.color,
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
              child: _category.showDelete
                  ? Container(
                      padding: const EdgeInsets.all(2),
                      child: InkWell(
                        onTap: widget.onDeletePressed as void Function()?,
                        child: ClipOval(
                          child: Container(
                            width: 24,
                            height: 24,
                            color: Theme.of(context).textTheme.headline1!.color,
                            child: Icon(
                              Icons.close,
                              color: Theme.of(context).backgroundColor,
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
