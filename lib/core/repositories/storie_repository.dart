import '../../core/models/storie_model.dart';

import '../models/base_request.dart';
import '../models/base_response.dart';
import '../network/api_hosts.dart';
import '../network/interface_http_client.dart';
import 'interface_repository.dart';

class StorieRepository implements Repository<StorieModel> {
  final InterfaceHttpClient client;

  StorieRepository(this.client);

  @override
  Future<BaseResponse> create(StorieModel model) {
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> delete(StorieModel model) {
    throw UnimplementedError();
  }

  @override
  Future<StorieModel?> get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future<List<StorieModel>> listAll() async {
    final response = await client.get(
      BaseRequest(path: ApiStories.home),
    );
    return (response.data as List)
        .map(
          (e) => StorieModel.fromJson(e),
        )
        .toList();
  }

  Future<List<StorieModel>> listCategory(String category) async {
    final req = BaseRequest(path: '${ApiStories.home}?category=$category');
    final response = await client.get(
      req,
    );
    return (response.data as List)
        .map(
          (e) => StorieModel.fromJson(e),
        )
        .toList();
  }

  @override
  Future<BaseResponse> update(StorieModel model) {
    throw UnimplementedError();
  }
}
