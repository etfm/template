import 'package:flutter/foundation.dart';
import 'package:template/config/cache/cache.dart';
import 'package:get/get.dart';

import 'base_http.dart';

class Http extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Cache.getBaseUrl();

    httpClient.timeout = const Duration(seconds: 15);

    /// 鉴权设置
    httpClient.addAuthenticator<dynamic>((request) {
      request.headers['Authorization'] = Cache.getToken();
      return request;
    });

    /// 请求前设置
    httpClient.addRequestModifier<dynamic>((request) {
      debugPrint(
          '---api-request--->url--> ${httpClient.baseUrl}${request.url.path}' +
              ' queryParameters: ${request.url.queryParameters}');
      debugPrint('---api-request--->headers--->${request.headers}');
      debugPrint('---api-request--->data--->${request.url.data}');
      return request;
    });

    /// 请求之后设置
    httpClient.addResponseModifier<dynamic>((request, response) {
      debugPrint('---api-response--->resp----->${response.body}');
      ResponseData respData = ResponseData.fromJson(response.body);

      /// 登录权限
      if (response.unauthorized) {
        throw const UnAuthorizedException();
      }

      /// 访问通过
      if (response.isOk) {
        return Response(
          request: request,
          statusCode: respData.code,
          statusText: respData.message,
          body: respData.data,
        );
      } else {
        /// 失败抛出错误
        throw NotSuccessException.fromRespData(respData);
      }
    });

    super.onInit();
  }
}
