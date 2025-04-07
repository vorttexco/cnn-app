import 'package:cnn_brasil_app/core/index.dart';

class LiveRepository implements Repository<LiveStreamModel> {
  final InterfaceHttpClient client;

  LiveRepository(this.client);

  @override
  Future<BaseResponse> create(LiveStreamModel model) {
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> delete(LiveStreamModel model) {
    throw UnimplementedError();
  }

  @override
  Future<LiveStreamModel?> get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future<List<LiveStreamModel>> listAll() async {
    throw UnimplementedError();
  }

  Future<List<LiveStreamModel>> playlist(String section) async {
    final response = await client.get(
      BaseRequest(path: ApiLiveStream.playlist(section)),
    );
    return (response.data as List)
        .map(
          (e) => LiveStreamModel.fromJson(e),
        )
        .toList();
  }

  Future<LiveOnModel?> onLive() async {
    final response = await client.get(
      BaseRequest(path: ApiLiveStream.onlive),
    );

    if (response.data == null) return null;

    return LiveOnModel.fromJson(response.data);
  }

  @override
  Future<BaseResponse> update(LiveStreamModel model) {
    throw UnimplementedError();
  }
}
