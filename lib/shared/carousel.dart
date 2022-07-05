import 'dart:io';

import 'package:flutter/material.dart';

import 'package:wecount/models/photo_model.dart' show PhotoModel;

class Carousel extends StatefulWidget {
  final int currentPage;
  final List<PhotoModel> picture;
  final double height;
  final double viewportFraction;
  final Function(int)? onPressed;

  const Carousel({
    Key? key,
    required this.picture,
    this.currentPage = 0,
    this.height = 256.0,
    this.viewportFraction = 1.0,
    this.onPressed,
  }) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int? currentPage;
  late PageController _controller;

  @override
  initState() {
    super.initState();

    _controller = PageController(
      initialPage: currentPage!,
      keepPage: false,
      viewportFraction: widget.viewportFraction,

      /// width percentage
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        itemCount: widget.picture.length,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        controller: _controller,
        itemBuilder: (context, index) {
          return builder(index);
        },
        pageSnapping: true,
      ),
    );
  }

  builder(int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value = 1.0;
        if (_controller.position.haveDimensions) {
          value = _controller.page! - index;
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * widget.height,
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
              height: widget.height,
              child: ButtonTheme(
                minWidth: double.infinity,
                // ignore: deprecated_member_use
                child: FlatButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () => widget.onPressed!(index),
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
                          File(widget.picture[index].file!.path),
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
                  '${index + 1} / ${widget.picture.length}',
                  style: const TextStyle(
                    color: Color(0xffffffff),
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
    );
  }
}
