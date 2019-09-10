import 'package:bookoo2/models/Category.dart' show iconMaps, categoryIcons;
import 'package:bookoo2/utils/asset.dart' as Asset;
import 'package:bookoo2/shared/edit_text_box.dart';
import 'package:bookoo2/utils/localization.dart';
import 'package:flutter/material.dart';

class CategoryAdd extends StatefulWidget {
  @override
  _CategoryAddState createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  int selectedIconIndex;
  
  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);

    Widget renderIcons() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: SingleChildScrollView(
          child: Wrap(
            children: categoryIcons.asMap().map((int i, AssetImage icon) {
              return MapEntry(i, Container(
                padding: EdgeInsets.only(left: 8, bottom: 8),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedIconIndex = i;
                    });
                  },
                  child: Opacity(
                    opacity: i == selectedIconIndex ? 1.0 : 0.4,
                    child: Image(
                      image: icon,
                      width: 72,
                      height: 72,
                    ),
                  ),
                ),
              ));
            }).values.toList(),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 24),
                      child: Text(
                        _localization.trans('CATEGORY_ADD'),
                        style: TextStyle(
                          fontSize: 28,
                          color: Theme.of(context).textTheme.title.color,
                        ),
                      ),
                    ),
                    EditTextBox(
                      margin: EdgeInsets.only(bottom: 16, left: 24, right: 24),
                      hintText: _localization.trans('CATEGORY_ADD_HINT'),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 24, right: 8),
                            child: Icon(Icons.star, size: 20, color: Asset.Colors.mediumGray),
                          ),
                          Text(
                            _localization.trans('ICON_SELECT'),
                            style: TextStyle(
                              color: Asset.Colors.mediumGray,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(child: renderIcons()),
                  ],
                ),
              ),
            ),
            Container(
              height: 68,
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 40),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        _localization.trans('CANCEL'),
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.display2.color,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        _localization.trans('DONE'),
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.display2.color,
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