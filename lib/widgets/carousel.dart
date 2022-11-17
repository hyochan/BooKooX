import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:wecount/models/photo.dart' show Photo;

class Carousel extends HookWidget {
  final currentPage;
  final List<Photo> picture;
  final double height;
  final double viewportFraction;
  final Function(int)? onPressed;

  Carousel({
    required this.picture,
    this.currentPage = 0,
    this.height = 256.0,
    this.viewportFraction = 1.0,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final List<Photo> picture;
    final double? height;
    final double? viewportFraction;
    var currentPage = useState<int?>(null);

    PageController? _controller;

    builder(int index) {
      double screenWidth = MediaQuery.of(context).size.width;
      return AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) {
          double value = 1.0;
          if (_controller!.position.haveDimensions) {
            value = _controller!.page! - index;
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
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                  width: double.infinity,
                  height: this.height,
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    child: TextButton(
                      onPressed: () => this.onPressed!(index),
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
                  margin: EdgeInsets.only(bottom: 20.0),
                  width: 72.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1} / ${this.picture.length}',
                      style: TextStyle(
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w100,
                        fontFamily: "AppleSDGothicNeo",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    useEffect(() {
      _controller = PageController(
        initialPage: currentPage.value!,
        keepPage: false,
        viewportFraction: this.viewportFraction!,

        /// width percentage
      );
      return () {
        _controller!.dispose();
      };
    }, []);

    return Container(
      height: this.height,
      child: PageView.builder(
        itemCount: this.picture.length,
        onPageChanged: (value) {
          currentPage.value = value;
        },
        controller: _controller,
        itemBuilder: (context, index) {
          return builder(index);
        },
        pageSnapping: true,
      ),
    );
  }
}
