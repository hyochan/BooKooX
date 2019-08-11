import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/header.dart' show renderHeaderClose;

class MyLedgers extends StatefulWidget {
  MyLedgers({Key key}) : super(key: key);

  @override
  _MyLedgersState createState() => new _MyLedgersState();
}

class _MyLedgersState extends State<MyLedgers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: renderHeaderClose(
        context: context,
        brightness: Brightness.light,
        title: Container(
          color: Colors.white,
        ),
        actions: [
          
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(top: 44.0, left: 60.0, right: 60.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
