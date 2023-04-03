import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageHelper {
  static String wrapAssets(String url) {
    return "assets/images/$url";
  }

  static Widget placeHolder({required double width, required double height}) {
    return SizedBox(
        width: width,
        height: height,
        child: CupertinoActivityIndicator(radius: min(10.0, width / 3)));
  }

  static Widget error(
      {required double width, required double height, double? size}) {
    return SizedBox(
      width: width,
      height: height,
      child: Icon(
        Icons.error_outline,
        size: size,
      ),
    );
  }
}
