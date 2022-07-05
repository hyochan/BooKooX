import 'package:flutter/material.dart';

import '../utils/localization.dart';

class CircleLoadingIndicator extends StatelessWidget {
  const CircleLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          semanticsLabel: t('LOADING'),
          backgroundColor: Theme.of(context).primaryColor,
          strokeWidth: 2,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
