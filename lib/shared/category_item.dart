import 'package:bookoo2/models/Category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryItem extends StatefulWidget {
  CategoryItem({
    @required this.category,
  });
  final Category category;

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
            print('tap');
          },
          onLongPress: () {
            print('long pressed!');
            setState((){
              category.showDelete = !category.showDelete;
            });
          },
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
                    child: Text(
                      category.label ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.title.color,
                      ),
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
                    onTap: () {
                      print('tap del icon');
                    },
                    child: Icon(
                      Icons.delete_outline,
                      size: 24,
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