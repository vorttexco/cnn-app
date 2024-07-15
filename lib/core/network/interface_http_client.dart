import '../models/base_request.dart';
import '../models/base_response.dart';

abstract class InterfaceHttpClient {
  Future<BaseResponse> post(BaseRequest request);
  Future<BaseResponse> get(BaseRequest request);
  Future<BaseResponse> patch(BaseRequest request);
  Future<BaseResponse> put(BaseRequest request);
  Future<BaseResponse> delete(BaseRequest request);
}
