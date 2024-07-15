import '../models/base_response.dart';

abstract class Repository<T> {
  Future<List<T>> listAll();
  Future<T?> get(String? id);
  Future<BaseResponse> update(T model);
  Future<BaseResponse> create(T model);
  Future<BaseResponse> delete(T model);
}
