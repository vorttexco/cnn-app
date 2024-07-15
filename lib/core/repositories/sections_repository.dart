import 'package:cnn_brasil_app/core/index.dart';

class SectionsRepository implements Repository<StorieModel> {
  final InterfaceHttpClient client;

  SectionsRepository(this.client);

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
    throw UnimplementedError();
  }

  Future<List<CnnMenuModel>> submenu(String section) async {
    final response = await client.get(
      BaseRequest(path: ApiSections.menu(section)),
    );
    return (response.data as List)
        .map(
          (e) => CnnMenuModel.fromJson(e),
        )
        .toList();
  }

  @override
  Future<BaseResponse> update(StorieModel model) {
    throw UnimplementedError();
  }
}
