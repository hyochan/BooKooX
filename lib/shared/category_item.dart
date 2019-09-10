import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookoo2/models/Category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryItem extends StatefulWidget {
  CategoryItem({
    this.key,
    @required this.category,
    this.onSelectPressed,
    this.onDeletePressed,
  });
  final Key key;
  final Category category;
  final Function onDeletePressed;
  final Function onSelectPressed;

  @override
  _CategoryItemState createState() => _CategoryItemState(category);
}

class _CategoryItemState extends State<CategoryItem> {
  _CategoryItemState(this.category);
  Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 8),
      child: InkWell(
        onTap: () {
          widget.onSelectPressed();
        },
        onLongPress: () => setState((){
          category.showDelete = !category.showDelete;
        }),

        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Image(
                  image: category.getIconImage(category.iconId),
                  width: 72,
                  height: 72,
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  width: 80,
                  child: AutoSizeText(
                    category.label ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.title.color,
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
              child: category.showDelete ? Container(
                padding: EdgeInsets.all(2),
                child: InkWell(
                  onTap: widget.onDeletePressed,
                  child: ClipOval(
                    child: Container(
                      width: 24,
                      height: 24,
                      color: Theme.of(context).textTheme.title.color,
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).backgroundColor,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ) : Container(),
            ),
          ],
        ),
      ),
    );
  }
}