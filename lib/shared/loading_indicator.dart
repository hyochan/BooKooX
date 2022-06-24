import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
    this.color,
    this.size = 50,
  }) : super(key: key);

  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: color ?? Theme.of(context).indicatorColor,
          size: size,
        ),
      ),
    );
  }
}
