import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

/// @description 加载框
/// @version: 1.0

enum Category {
  Ring,
  FadingCircle,
  Indicator,
}

///加载框
class ProgressDialog {
  static bool _isShowing = false;

  ///展示
  static void showProgress({
    Color maskColor = Colors.transparent,
    Category category = Category.Indicator,
    Color spinKitColor = Colors.white,
    double width = 120,
    double height = 80,
    String title = '正在加载中...',
  }) {
    if (!_isShowing) {
      _isShowing = true;
      Navigator.push(
        Get.context!,
        _PopRoute(
          child: _Progress(
              maskColor: maskColor,
              dismiss: dismiss,
              category: category,
              width: width,
              height: height,
              title: title,
              spinKitColor: spinKitColor),
        ),
      );
    }
  }

  ///隐藏
  static void dismiss() {
    if (_isShowing) {
      Navigator.of(Get.context!).pop();
      _isShowing = false;
    }
  }
}

///Widget
class _Progress extends StatelessWidget {
  final Color maskColor;
  final Color spinKitColor;
  final Function dismiss;
  final Category category;
  final double width;
  final double height;
  final String title;

  const _Progress({
    Key? key,
    required this.dismiss,
    required this.maskColor,
    required this.category,
    required this.spinKitColor,
    required this.width,
    required this.height,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Material(
        color: maskColor,
        child: Center(
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _widget(),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(title),
                )
              ],
            ),
          ),
        ),
      ),
      onWillPop: () {
        return Future.value(false);
      },
    );
  }

  Widget _widget() {
    Widget widget;
    switch (category) {
      case Category.FadingCircle:
        widget = SpinKitFadingCircle(color: spinKitColor);
        break;
      case Category.Ring:
        widget = SpinKitRing(color: spinKitColor, lineWidth: 3, size: 40);
        break;
      default:
        widget = const SpinKitFadingCircle(color: Colors.white, size: 40);
        break;
    }

    return widget;
  }
}

///Route
class _PopRoute extends PopupRoute {
  final Duration _duration = const Duration(milliseconds: 200);
  Widget child;

  _PopRoute({required this.child});

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
