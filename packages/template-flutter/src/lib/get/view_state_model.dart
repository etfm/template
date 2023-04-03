import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:template/config/net/base_http.dart';
import 'package:template/get/view_state.dart';
import 'package:template/utils/toast_utils.dart';
import 'package:get/get.dart';

abstract class ViewStateModel<T> extends GetxController with StateMixin<T> {
  late ViewStateError _viewStateError;

  ViewStateError get viewStateError => _viewStateError;

  /// [e]分类Error和Exception两种
  void setError(e, stackTrace, {String? message}) {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;

    if (e) {
      e = e.error;
      if (e is UnAuthorizedException) {
        stackTrace = null;
        errorType = ViewStateErrorType.unauthorizedError;
      } else if (e is NotSuccessException) {
        stackTrace = null;
        message = e.message;
      } else if (e is SocketException) {
        errorType = ViewStateErrorType.networkTimeOutError;
        message = e.message.isEmpty ? e.osError?.message : e.message;
      } else {
        if (kDebugMode) {
          print(e);
          print(e is SocketException);
        }
        message = e.message;
      }
    }
    _viewStateError = ViewStateError(
      errorType: errorType,
      message: message,
      errorMessage: e.toString(),
    );
    change(null, status: RxStatus.error(_viewStateError.toJson() as String?));
    printErrorStack(e, stackTrace);
    onError(viewStateError);
  }

  void onError(ViewStateError viewStateError) {}

  /// 显示错误消息
  showErrorMessage(context, {String? message}) {
    if (viewStateError.isNetworkTimeOut) {
      message ??= '网络错误';
    } else {
      message ??= viewStateError.message;
    }
    Future.microtask(() {
      ToastUtils.showToast(message!);
    });
  }

  @override
  String toString() {
    return 'BaseModel{_viewState: $status, _viewStateError: $viewStateError}';
  }

  @override
  void dispose() {
    debugPrint('view_state_model dispose -->$runtimeType');
    super.dispose();
  }
}

/// [e]为错误类型 :可能为 Error , Exception ,String
/// [s]为堆栈信息
printErrorStack(e, s) {
  debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----error-----↓↓↓↓↓↓↓↓↓↓----->
$e
<-----↑↑↑↑↑↑↑↑↑↑-----error-----↑↑↑↑↑↑↑↑↑↑----->''');
  if (s != null) {
    debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----trace-----↓↓↓↓↓↓↓↓↓↓----->
$s
<-----↑↑↑↑↑↑↑↑↑↑-----trace-----↑↑↑↑↑↑↑↑↑↑----->
    ''');
  }
}
