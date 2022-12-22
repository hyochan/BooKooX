import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/models/ledger_item_model.dart';
import 'package:wecount/models/photo_model.dart';

class Carousel extends HookWidget {
  final double currentPage;
  final List<PhotoModel> picture;
  final double height;
  final double viewportFraction;
  final Function(int)? onPressed;

  const Carousel({
    super.key,
    required this.picture,
    this.currentPage = 0,
    this.height = 256.0,
    this.viewportFraction = 1.0,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final List<PhotoModel> picture;
    final double? height;
    final double? viewportFraction;
    var currentPage = useState<int?>(null);

    PageController? controller;

    AnimatedBuilder builder(int index) {
      double screenWidth = MediaQuery.of(context).size.width;
      return AnimatedBuilder(
        animation: controller!,
        builder: (context, child) {
          double value = 1.0;
          if (controller!.position.haveDimensions) {
            value = controller!.page! - index;
            value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
          }

          return Center(
            child: SizedBox(
              height: Curves.easeOut.transform(value) * this.height,
              width: Curves.easeOut.transform(value) * screenWidth,
              child: child,
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Positioned(
              child: SizedBox(
                width: double.infinity,
                height: this.height,
                child: ButtonTheme(
                  minWidth: double.infinity,
                  child: TextButton(
                    onPressed: () => onPressed!(index),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          // child: CachedNetworkImage(
                          //   fit: BoxFit.cover,
                          //   placeholder: Image(
                          //     image: Theme.Icons.icLoadingImage,
                          //   ),
                          //   imageUrl: imgUrls[index],
                          // )
                          child: Image.file(
                            File(this.picture[index].file!.path),
                            fit: BoxFit.cover,
                            height: 72,
                            width: 84,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                width: 72.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.3),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Center(
                  child: Text(
                    '${index + 1} / ${this.picture.length}',
                    style: const TextStyle(
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w100,
                      fontFamily: 'AppleSDGothicNeo',
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    useEffect(() {
      controller = PageController(
        initialPage: currentPage.value!,
        keepPage: false,
        viewportFraction: this.viewportFraction,

        /// width percentage
      );
      return () {
        controller!.dispose();
      };
    }, []);

    return SizedBox(
      height: this.height,
      child: PageView.builder(
        itemCount: this.picture.length,
        onPageChanged: (value) {
          currentPage.value = value;
        },
        controller: controller,
        itemBuilder: (context, index) {
          return builder(index);
        },
        pageSnapping: true,
      ),
    );
  }
}
