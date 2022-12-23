import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:wecount/screens/intro.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/localization.dart';
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

class Tutorial extends HookWidget {
  const Tutorial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int pageCnt = 2;
    var currentIndex = useState(0);

    var pageController = PageController(
      initialPage: 0,
    );

    void onPressNext() {
      if (currentIndex.value == pageCnt) {
        navigation.navigate(context, AppRoute.intro.path, reset: true);
        return;
      }

      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }

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
                    ? asset.AppIcons.tutorial1
                    : page == 1
                        ? asset.AppIcons.tutorial2
                        : page == 2
                            ? asset.AppIcons.tutorial3
                            : asset.AppIcons.tutorial1,
                width: 200,
                height: 160,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 56),
              child: Text(
                page == 0
                    ? localization(context).recordIt
                    : page == 1
                        ? localization(context).shareIt
                        : page == 2
                            ? localization(context).takeCare
                            : localization(context).recordIt,
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
                    ? localization(context).tutorial1Detail
                    : page == 1
                        ? localization(context).tutorial2Detail
                        : page == 2
                            ? localization(context).tutorial3Detail
                            : localization(context).tutorial1Detail,
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
      required int index,
      int page = 0,
    }) {
      return Container(
        key: key,
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: page == index ? Colors.white : mainColor,
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
      required int index,
    }) {
      return SizedBox(
        child: Row(
          children: <Widget>[
            renderIndicator(
              index: index,
              page: 0,
            ),
            renderIndicator(
              index: index,
              page: 1,
            ),
            renderIndicator(
              index: index,
              page: 2,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: mainColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: PageView(
                  onPageChanged: (int page) {
                    currentIndex.value = page;
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
                    renderIndicatorGroup(index: currentIndex.value),
                    TextButton(
                      onPressed: onPressNext,
                      child: Text(
                        localization(context).next,
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.bg.paper,
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
