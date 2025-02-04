class ArticleGalleryModel {
  int? id;
  String? title;
  String? description;
  List<Images>? images;

  ArticleGalleryModel({this.id, this.title, this.description, this.images});

  ArticleGalleryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  String? url;
  String? caption;
  String? credits;
  String? alt;

  Images({this.id, this.url, this.caption, this.credits, this.alt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    caption = json['caption'];
    credits = json['credits'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['caption'] = caption;
    data['credits'] = credits;
    data['alt'] = alt;
    return data;
  }
}