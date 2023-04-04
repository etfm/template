import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:template/helper/resource_mananger.dart';

enum ImageType {
  normal,
  random, //随机
}

class WrapperImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final ImageType imageType;
  final Function(String)? onTap;

  const WrapperImage({
    Key? key,
    required this.url,
    required this.width,
    required this.height,
    this.imageType = ImageType.normal,
    this.fit = BoxFit.cover,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder: (_, __) =>
          ImageHelper.placeHolder(width: width, height: height),
      errorWidget: (_, __, ___) =>
          ImageHelper.error(width: width, height: height, size: null),
      fit: fit,
    );
  }

  String get imageUrl {
    switch (imageType) {
      case ImageType.normal:
        return url;
      default:
        return url;
    }
  }
}
