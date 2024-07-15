import '../index.dart';

class WrapperLiveStreamModel {
  final String title;
  final List<LiveStreamModel> items;

  WrapperLiveStreamModel({
    required this.title,
    required this.items,
  });

  static WrapperLiveStreamModel toView(WrapperLiveStreamModel model) {
    if (model.items.isEmpty) {
      return WrapperLiveStreamModel(items: [], title: model.title);
    }
    bool sort = true;
    for (var element in model.items) {
      if (element.publishDate == null) {
        sort = false;
      }
    }

    try {
      if (sort) {
        model.items.sort(
          (a, b) => DateTime.parse(b.publishDate!)
              .compareTo(DateTime.parse(a.publishDate!)),
        );
      }
    } on Exception catch (e) {
      Logger.log(e.toString());
    }

    final firstFourItemsTake =
        model.items.take(AppConstants.TOTAL_PLAYLIST_MINIMAL).toList();

    return WrapperLiveStreamModel(
        title: model.title, items: firstFourItemsTake);
  }
}
