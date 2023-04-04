enum ViewStateErrorType {
  defaultError,
  networkTimeOutError, //网络超时错误
  unauthorizedError //为授权(一般为未登录)
}

class ViewStateError {
  ViewStateErrorType? errorType;
  String? message;
  String? errorMessage;

  ViewStateError({this.errorType, this.message, this.errorMessage}) {
    message ??= errorMessage;
  }

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  get isDefaultError => errorType == ViewStateErrorType.defaultError;
  get isNetworkTimeOut => errorType == ViewStateErrorType.networkTimeOutError;
  get isUnauthorized => errorType == ViewStateErrorType.unauthorizedError;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorType'] = errorType;
    data['message'] = message;
    data['errorMessage'] = errorMessage;
    return data;
  }

  ViewStateError.fromJson(Map<String, dynamic> json) {
    errorType = json['errorType'];
    message = json['message'];
    errorMessage = json['errorMessage'];
  }

  @override
  String toString() {
    return 'ViewStateError{errorType: $errorType, message: $message, errorMessage: $errorMessage}';
  }
}
