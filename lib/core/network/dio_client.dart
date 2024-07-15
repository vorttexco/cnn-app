import 'dart:io';

import 'package:dio/dio.dart';

import '../app/app_label.dart';
import '../debug/logger.dart';
import '../managers/app_manager.dart';
import '../models/base_request.dart';
import '../models/base_response.dart';
import 'interface_http_client.dart';

class ApiConnector implements InterfaceHttpClient {
  final _dio = Dio();
  final baseError = BaseResponse(false,
      code: -1, message: 'Ops :( tivemos um problema com nosso sistema.');

  Future<Map<String, String>> _customHeaders(BaseRequest request) async {
    const token = '';
    return {
      Headers.contentTypeHeader: Headers.jsonContentType,
      'Authorization': 'Bearer $token',
    };
  }

  String _url(BaseRequest request) {
    String? url = request.url;

    if (url != null) {
      Logger.log('REQUEST-> METHOD: ${request.method} URL:$url');
      return url;
    }
    late String host = AppManager.hostApi;
    url = '$host${request.path}';
    Logger.log('REQUEST-> METHOD: ${request.method} URL:$url');
    return url;
  }

  @override
  Future<BaseResponse> get(BaseRequest request) async {
    try {
      final url = _url(request);

      final headers = {
        ...await _customHeaders(request),
        if (request.headers != null) ...request.headers!
      };
      var response = await _dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );

      return BaseResponse(
        true,
        code: response.statusCode!,
        data: _response(response),
      );
    } on DioException catch (e) {
      return _getErrorMessage(e);
    } catch (e) {
      Logger.log(e.toString());
      return baseError;
    }
  }

  @override
  Future<BaseResponse> delete(BaseRequest request) async {
    try {
      final headers = {
        ...await _customHeaders(request),
        if (request.headers != null) ...request.headers!
      };
      var response = await _dio.delete(
        _url(request),
        data: request.body,
        options: Options(
          headers: headers,
        ),
      );

      return BaseResponse(
        true,
        code: response.statusCode!,
        data: _response(response),
      );
    } on DioException catch (e) {
      return _getErrorMessage(e);
    } catch (e) {
      Logger.log(e.toString());
      return baseError;
    }
  }

  @override
  Future<BaseResponse> patch(BaseRequest request) async {
    try {
      final url = _url(request);
      final headers = {
        ...await _customHeaders(request),
        if (request.headers != null) ...request.headers!
      };

      var response = await _dio.patch(
        url,
        data: request.body,
        options: Options(
          headers: headers,
        ),
      );

      return BaseResponse(
        response.statusCode! < 300 ? true : false,
        code: response.statusCode!,
        data: _response(response),
      );
    } on DioException catch (e) {
      return _getErrorMessage(e);
    } catch (e) {
      Logger.log(e.toString());
      return baseError;
    }
  }

  @override
  Future<BaseResponse> post(BaseRequest request,
      {bool useHeaders = true}) async {
    try {
      Map<String, String>? headers;
      // if (useHeaders) {
      //   headers = {
      //     ...await _customHeaders(request),
      //     if (request.headers != null) ...request.headers!
      //   };
      // }
      final url = _url(request);

      var response = await _dio.post(
        url,
        data: request.body,
        options: Options(
          headers: headers,
        ),
      );

      return BaseResponse(
        true,
        code: response.statusCode!,
        data: _response(response),
      );
    } on DioException catch (e) {
      return _getErrorMessage(e);
    } catch (e) {
      Logger.log(e.toString());
      return baseError;
    }
  }

  @override
  Future<BaseResponse> put(BaseRequest request,
      {bool useHeaders = true}) async {
    try {
      Map<String, String>? headers;
      if (useHeaders) {
        headers = {
          ...await _customHeaders(request),
          if (request.headers != null) ...request.headers!
        };
      }
      final url = _url(request);

      var response = await _dio.put(
        url,
        data: request.body,
        options: Options(
          headers: headers,
        ),
      );

      return BaseResponse(
        true,
        code: response.statusCode!,
        data: _response(response),
      );
    } on DioException catch (e) {
      return _getErrorMessage(e);
    } catch (e) {
      Logger.log(e.toString());
      return baseError;
    }
  }

  dynamic _response(response) {
    switch (response.statusCode) {
      case 201:
      case 200:
        final data = response.data;
        return data;
      default:
        return response.data;
    }
  }

  Future<BaseResponse> _getErrorMessage(DioException e) async {
    Logger.log('response:${e.response.toString()}');
    if ((e.response?.statusCode ?? 0) > 500) {
      return BaseResponse(
        false,
        code: e.response!.statusCode!,
        data: AppLabel.ops,
      );
    }

    if (e.response != null &&
        e.response!.statusCode == HttpStatus.preconditionFailed) {
      return BaseResponse(
        false,
        code: e.response!.statusCode!,
        data: e.response!.data,
      );
    }
    BaseResponse response;
    if (e.response != null) {
      if (e.response!.data['error'] != null) {
        response = BaseResponse(
          false,
          code: e.response?.statusCode ?? -1,
          data: e.response?.data,
          message: e.response!.data['error'],
        );
      }
      if (e.response!.data['message'] != null) {
        response = BaseResponse(
          false,
          code: e.response?.statusCode ?? -1,
          data: e.response?.data,
          message: e.response?.data['message'].toString(),
        );
      } else {
        response = BaseResponse(
          false,
          code: e.response?.statusCode ?? -1,
          data: e.response?.data,
          message: 'Ops :( tivemos um problema com nosso sistema.',
        );
      }
      return response;
    } else {
      return BaseResponse(
        false,
        code: -1,
        data: e.response?.data,
        message: 'Ops :( tivemos um problema com nosso sistema.',
      );
    }
  }
}
