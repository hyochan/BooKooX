import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
    this.size,
    this.strokeWidth = 2,
  }) : super(key: key);

  final double? size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          semanticsLabel: '로딩중...',
          backgroundColor: Theme.of(context).primaryColor,
          strokeWidth: strokeWidth,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
