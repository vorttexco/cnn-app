import 'package:dio/dio.dart';

enum RequestType { post, delete, patch, get, upload }

class BaseRequest {
  final String? url;
  final String path;
  final Map<String, dynamic>? body;
  final Map<String, String>? headers;
  final FormData? formData;
  final bool followRedirects;
  final RequestType method;

  BaseRequest({
    required this.path,
    this.url,
    this.body,
    this.headers,
    this.formData,
    this.followRedirects = false,
    this.method = RequestType.get,
  });
}
