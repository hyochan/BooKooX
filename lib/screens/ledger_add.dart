import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/localization.dart';
import '../utils/asset.dart' as Asset;
import '../types/color.dart';
import '../widgets/header.dart' show renderHeaderBack;

class LedgerAdd extends StatefulWidget {
  LedgerAdd({Key key}) : super(key: key);

  @override
  _LedgerAddState createState() => new _LedgerAddState();
}

class _LedgerAddState extends State<LedgerAdd> {
  final List<ColorType> _items = [
    ColorType.PURPLE,
    ColorType.DUSK,
    ColorType.BLUE,
    ColorType.GREEN,
    ColorType.YELLOW,
    ColorType.ORANGE,
    ColorType.RED,
  ];
  ColorType selectedColor = ColorType.DUSK;

  void onPressCurrency() {

  }

  void onSelectColor(ColorType item) {
    setState(() {
      selectedColor = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);

    return Scaffold(
      backgroundColor: Asset.Colors.getColor(selectedColor),
      appBar: renderHeaderBack(
        context: context,
        iconColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 40, left: 40, right: 40),
              child: TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  hintMaxLines: 2,
                  border: InputBorder.none,
                  hintText: _localization.trans('LEDGER_NAME_HINT'),
                  hintStyle: TextStyle(
                    fontSize: 28.0,
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                  ),
                ),
                style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24, left: 40, right: 40, bottom: 20),
              height: 160,
              child: TextField(
                maxLines: 8,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: _localization.trans('LEDGER_DESCRIPTION_HINT'),
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                  ),
                ),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
            MaterialButton(
              padding: EdgeInsets.all(0.0),
              onPressed: onPressCurrency,
              child: Container(
                height: 80.0,
                width: double.infinity,
                padding: EdgeInsets.only(left: 40.0, right: 28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _localization.trans('CURRENCY'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'BRN | \$',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.chevron_right,
                            size: 16,
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.white70),
            Container(
              height: 80.0,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      _localization.trans('COLOR'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 32),
                      child: ListView.builder(
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _items.length,
                        itemExtent: 32,
                        itemBuilder: (context, index) {
                          final item = _items[index];
                          bool selected = item == selectedColor;
                          return ColorItem(
                            color: item,
                            onTap: () => onSelectColor(item),
                            selected: selected,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20, top: 46, bottom: 20),
                  child: SizedBox(
                    child: FlatButton(
                      padding: EdgeInsets.all(20),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.0),
                      ),
                      onPressed: () { },
                      child: Text(
                        _localization.trans('DONE'),
                        style: TextStyle(
                          color: Asset.Colors.getColor(selectedColor),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    width: 80.0,
                    height: 56.0,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ColorItem extends StatelessWidget {
  ColorItem({
    Key key,
    this.color,
    this.selected,
    this.onTap,
  }) : super(key: key);
  final ColorType color;
  final bool selected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ClipOval(
          child: Material(
            clipBehavior: Clip.hardEdge,
            color: Asset.Colors.getColor(color),
            child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ), 
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        selected == true
        ? Icon(
          Icons.check,
          color: Colors.white,
          size: 16,
        )
        : Container()
      ],
    );
  }
}
