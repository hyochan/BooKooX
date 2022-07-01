import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wecount/utils/colors.dart';

import '../utils/localization.dart';
import 'loading_indicator.dart';

class NetworkImageLoader extends StatelessWidget {
  const NetworkImageLoader({
    Key? key,
    this.imageURL,
    this.emptyImage,
    this.width = double.infinity,
    this.height = double.infinity,
  }) : super(key: key);

  final String? imageURL;
  final Widget? emptyImage;
  final double width;
  final double height;

  Widget _buildDefaultEmptyImage() {
    return Container(
      width: width,
      height: height,
      color: cloudyBlueColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Text(
            t('APP_NAME'),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyImage() =>
      emptyImage == null ? _buildDefaultEmptyImage() : emptyImage!;

  @override
  Widget build(BuildContext context) {
    return imageURL != null
        ? CachedNetworkImage(
            imageUrl: imageURL!,
            width: width,
            height: height,
            fit: BoxFit.cover,
            placeholder: (context, url) => const LoadingIndicator(),
            errorWidget: (_, __, ___) => _buildEmptyImage(),
          )
        : _buildEmptyImage();
  }
}
