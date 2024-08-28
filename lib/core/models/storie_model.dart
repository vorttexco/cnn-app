class StorieModel {
  int? id;
  String? title;
  String? thumbnail;
  String? excerpt;
  String? permalink;
  Category? category;

  StorieModel(
      {this.id,
      this.title,
      this.thumbnail,
      this.excerpt,
      this.permalink,
      this.category});

  StorieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    excerpt = json['excerpt'];
    permalink = json['permalink'];
    category =
        json['category'] == null ? null : Category.fromJson(json['category']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    data['excerpt'] = excerpt;
    data['permalink'] = permalink;
    data['category'] = category?.toJson();
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? color;
  List<dynamic>? hierarchy;

  Category({this.id, this.name, this.slug, this.hierarchy});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    color = json['color'];
    hierarchy = List<dynamic>.from(json['hierarchy']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['color'] = color;
    data['hierarchy'] = hierarchy;
    return data;
  }
}
