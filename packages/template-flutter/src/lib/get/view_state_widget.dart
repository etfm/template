import 'dart:convert';

import 'package:flutter/material.dart';

import '../helper/resource_mananger.dart';
import 'view_state.dart';

/// 加载中
class ViewStateBusyWidget extends StatelessWidget {
  const ViewStateBusyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

/// 基础Widget
class ViewStateWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final String? buttonTextData;
  final VoidCallback onPressed;

  const ViewStateWidget(
      {Key? key,
      this.title,
      this.message,
      this.image,
      this.buttonText,
      this.buttonTextData,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleStyle =
        Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.grey);
    var messageStyle = titleStyle.copyWith(
        color: titleStyle.color!.withOpacity(0.7), fontSize: 14);
    return ListView(
      children: <Widget>[
        image ??
            Icon(Icons.error_outline_outlined,
                size: 80, color: Colors.grey[500]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title ?? '加载失败',
                style: titleStyle,
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 200, minHeight: 150),
                child: SingleChildScrollView(
                  child: Text(message ?? '', style: messageStyle),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: ViewStateButton(
            child: buttonText,
            textData: buttonTextData,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

/// ErrorWidget
class ViewStateErrorWidget extends StatelessWidget {
  final String error;
  final String? title;
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final String? buttonTextData;
  final VoidCallback onPressed;

  const ViewStateErrorWidget(
      {Key? key,
      required this.error,
      this.title,
      this.message,
      this.image,
      this.buttonText,
      this.buttonTextData,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewStateError stateError = ViewStateError.fromJson(jsonDecode(error));

    Widget defaultImage =
        const Icon(Icons.error_outline, size: 100, color: Colors.grey);
    String defaultTitle = '加载失败';
    String errorMessage = stateError.message ?? '未知错误';
    String defaultTextData = "重试";

    switch (stateError.errorType) {
      case ViewStateErrorType.networkTimeOutError:
        defaultImage = Transform.translate(
          offset: const Offset(0, 0),
          child: const Icon(Icons.wifi_off_outlined,
              size: 100, color: Colors.grey),
        );
        defaultTitle = '网络连接异常,请检查网络或稍后重试';
        break;
      case ViewStateErrorType.defaultError:
        defaultImage =
            const Icon(Icons.error_outline, size: 100, color: Colors.grey);
        defaultTitle = '加载失败';
        break;
      case ViewStateErrorType.unauthorizedError:
        return ViewStateUnAuthWidget(
          image: image,
          message: message,
          buttonText: buttonText,
          onPressed: onPressed,
        );
    }
    return ViewStateWidget(
      onPressed: onPressed,
      image: image ?? defaultImage,
      title: title ?? defaultTitle,
      message: message ?? errorMessage,
      buttonTextData: buttonTextData ?? defaultTextData,
      buttonText: buttonText,
    );
  }
}

/// 页面无数据
class ViewStateEmptyWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final String buttonTextData;
  final VoidCallback onPressed;

  const ViewStateEmptyWidget(
      {Key? key,
      this.message,
      this.image,
      this.buttonText,
      this.buttonTextData = '刷新',
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: onPressed,
      image: image ??
          Image(
            fit: BoxFit.fill,
            image: AssetImage(ImageHelper.wrapAssets('empty.png')),
          ),
      title: message ?? '空空如也',
      buttonText: buttonText,
      buttonTextData: buttonTextData,
    );
  }
}

/// 页面未授权
class ViewStateUnAuthWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final VoidCallback onPressed;

  const ViewStateUnAuthWidget(
      {Key? key,
      this.message,
      this.image,
      this.buttonText,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: onPressed,
      image: image ?? const ViewStateUnAuthImage(),
      title: message ?? "未登录",
      buttonText: buttonText,
      buttonTextData: "登录",
    );
  }
}

/// 未授权图片
class ViewStateUnAuthImage extends StatelessWidget {
  const ViewStateUnAuthImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'loginLogo',
      child: Image.asset(
        ImageHelper.wrapAssets('login_logo.png'),
        width: 130,
        height: 100,
        fit: BoxFit.fitWidth,
        color: Theme.of(context).accentColor,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }
}

/// 公用Button
class ViewStateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final String? textData;

  const ViewStateButton(
      {Key? key, required this.onPressed, this.child, this.textData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: child ??
          Text(
            textData ?? '重试',
            style: const TextStyle(wordSpacing: 5),
          ),
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
        textStyle:
            MaterialStatePropertyAll<TextStyle>(TextStyle(color: Colors.grey)),
      ),
      onPressed: onPressed,
    );
  }
}
