import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/screens/intro.dart';

import 'package:wecount/utils/localization.dart' show Localization;
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/routes.dart';

class Tutorial extends HookWidget {
  const Tutorial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int pageCnt = 2; // 3
    var currentPage = useState<int>(0);
    var pageController = PageController(
      initialPage: 0,
    );
    void onNextPressed() {
      if (currentPage.value == pageCnt) {
        Navigator.pushNamedAndRemoveUntil(context, '/intro', (_) => false);
        return;
      }
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }

    var localization = Localization.of(context)!;

    Widget renderPage({
      Key? key,
      int page = 0,
    }) {
      return Container(
        key: key,
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 148),
              child: Image(
                image: page == 0
                    ? asset.Icons.tutorial1
                    : page == 1
                        ? asset.Icons.tutorial2
                        : page == 2
                            ? asset.Icons.tutorial3
                            : asset.Icons.tutorial1,
                width: 200,
                height: 160,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 56),
              child: Text(
                page == 0
                    ? localization.trans('RECORD_IT')!
                    : page == 1
                        ? localization.trans('SHARE_IT')!
                        : page == 2
                            ? localization.trans('TAKE_CARE')!
                            : localization.trans('RECORD_IT')!,
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                page == 0
                    ? localization.trans('TUTORIAL_1_DETAIL')!
                    : page == 1
                        ? localization.trans('TUTORIAL_2_DETAIL')!
                        : page == 2
                            ? localization.trans('TUTORIAL_3_DETAIL')!
                            : localization.trans('TUTORIAL_1_DETAIL')!,
                style: const TextStyle(
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
      Key? key,
      required currentPage,
      int page = 0,
    }) {
      return Container(
        key: key,
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: page == currentPage ? Colors.white : asset.Colors.main,
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
      Key? key,
      required currentPage,
    }) {
      return SizedBox(
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
      backgroundColor: asset.Colors.main,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: asset.Colors.main,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: PageView(
                  onPageChanged: (int page) {
                    currentPage.value = page;
                  },
                  controller: pageController,
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
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    renderIndicatorGroup(currentPage: currentPage),
                    TextButton(
                      onPressed: onNextPressed,
                      child: Text(
                        localization.trans('NEXT')!,
                        style: const TextStyle(
                          fontSize: 20,
                          color: asset.Colors.green,
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
