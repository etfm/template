/// 子类需要重写
abstract class BaseResponseData {
  dynamic code;
  String? message;
  dynamic data;

  bool get success;

  BaseResponseData({this.code, this.message, this.data});

  @override
  String toString() {
    return 'BaseRespData{code: $code, message: $message, data: $data}';
  }
}

/// 接口的code没有返回为true的异常
class NotSuccessException implements Exception {
  String? message;
  dynamic code;
  dynamic data;

  NotSuccessException.fromRespData(BaseResponseData respData) {
    message = respData.message;
    code = respData.code;
    data = respData.data;
  }

  @override
  String toString() {
    return 'NotExpectedException{respData: $message}';
  }
}

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}

class ResponseData extends BaseResponseData {
  @override
  bool get success => 200 == code;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['msg'];
    data = json['data'];
  }
}
