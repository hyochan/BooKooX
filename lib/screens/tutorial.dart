import 'package:flutter/material.dart';

import 'package:bookoox/utils/localization.dart' show Localization;
import 'package:bookoox/utils/asset.dart' as Asset;
import 'package:bookoox/utils/general.dart' show General;

class Tutorial extends StatefulWidget {
  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  final int pageCnt = 2; // 3
  int _currentPage = 0;
  var _pageController = PageController(
    initialPage: 0,
  );
  void onNextPressed() {
    if (_currentPage == pageCnt) {
      Navigator.pushNamedAndRemoveUntil(context, '/intro', (_) => false);
      return;
    }
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);

    Widget renderPage({
      Key key,
      int page = 0,
    }) {
      return Container(
        key: key,
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 148),
              child: Image(
                image: page == 0
                  ? Asset.Icons.tutorial1
                  : page == 1
                  ? Asset.Icons.tutorial2
                  : page == 2
                  ? Asset.Icons.tutorial3
                  : Asset.Icons.tutorial1,
                width: 200,
                height: 160,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 56),
              child: Text(
                page == 0
                  ? _localization.trans('RECORD_IT')
                  : page == 1
                  ? _localization.trans('SHARE_IT')
                  : page == 2
                  ? _localization.trans('TAKE_CARE')
                  : _localization.trans('RECORD_IT'),
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                page == 0
                  ? _localization.trans('TUTORIAL_1_DETAIL')
                  : page == 1
                  ? _localization.trans('TUTORIAL_2_DETAIL')
                  : page == 2
                  ? _localization.trans('TUTORIAL_3_DETAIL')
                  : _localization.trans('TUTORIAL_1_DETAIL'),
                style: TextStyle(
                  fontSize: 16,
                  height: 1.3,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    Widget renderIndicator({
      Key key,
      @required  currentPage,
      int page = 0,
    }) {
      return Container(
        key: key,
        margin: EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: page == currentPage ? Colors.white : Asset.Colors.dusk,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 1,
            color: Colors.white,
          ),
        ),
        height: 8,
        width: 8,
      );
    }

    Widget renderIndicatorGroup({
      Key key,
      @required currentPage,
    }) {
      return Container(
        child: Row(
          children: <Widget>[
            renderIndicator(
              currentPage: currentPage,
              page: 0,
            ),
            renderIndicator(
              currentPage: currentPage,
              page: 1,
            ),
            renderIndicator(
              currentPage: currentPage,
              page: 2,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Asset.Colors.dusk,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Asset.Colors.dusk,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: PageView(
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    renderPage(page: 0),
                    renderPage(page: 1),
                    renderPage(page: 2),
                  ],
                ),
              ),
              Container(
                height: 56,
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    renderIndicatorGroup(currentPage: _currentPage),
                    FlatButton(
                      onPressed: onNextPressed,
                      child: Text(
                        _localization.trans('NEXT'),
                        style: TextStyle(
                          fontSize: 20,
                          color: Asset.Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
