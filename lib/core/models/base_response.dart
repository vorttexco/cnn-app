class BaseResponse {
  final bool success;
  final int code;
  final String? message;
  final dynamic data;

  BaseResponse(
    this.success, {
    required this.code,
    this.message,
    this.data,
  });

  static BaseResponse noContent() => BaseResponse(true, code: 204);
}
