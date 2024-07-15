import 'package:cnn_brasil_app/core/index.dart';

class HomeRepository implements Repository<CnnMenuModel> {
  final InterfaceHttpClient client;

  HomeRepository(this.client);

  @override
  Future<BaseResponse> create(CnnMenuModel model) {
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> delete(CnnMenuModel model) {
    throw UnimplementedError();
  }

  @override
  Future<CnnMenuModel?> get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future<List<CnnMenuModel>> listAll() async {
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> update(CnnMenuModel model) {
    throw UnimplementedError();
  }

  Future<List<CnnMenuModel>> menuSections() async {
    final response = await client.get(
      BaseRequest(path: ApiSections.menuSections),
    );
    if (response.success) {
      return (response.data as List)
          .map((e) => CnnMenuModel.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<List<CnnMenuModel>> menuHome() async {
    final response = await client.get(
      BaseRequest(path: ApiHome.menuHome),
    );
    if (response.success) {
      return (response.data as List)
          .map((e) => CnnMenuModel.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<List<CnnMenuModel>> menuCopyright() async {
    final response = await client.get(
      BaseRequest(path: ApiHome.menuCopyright),
    );
    if (response.success) {
      return (response.data as List)
          .map((e) => CnnMenuModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
