class CnnMenuModel {
  int? id;
  int? order;
  String? title;
  String? slug;
  String? hierarchy;
  String? url;
  String? parent;
  String? target;
  MenuColor? color;
  List<CnnMenuModel>? child;

  CnnMenuModel(
      {this.id,
      this.order,
      this.title,
      this.slug,
      this.hierarchy,
      this.url,
      this.parent,
      this.target,
      this.color,
      this.child});

  CnnMenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order = json['order'];
    title = json['title'];
    slug = json['slug'];
    hierarchy = json['hierarchy'];
    url = json['url'];
    parent = json['parent'];
    target = json['target'];
    color = json['color'] == null ? null : MenuColor.fromJson(json['color']);
    child = json['child'] == null
        ? []
        : (json['child'] as List)
            .map(
              (e) => CnnMenuModel.fromJson(e),
            )
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order'] = order;
    data['title'] = title;
    data['slug'] = slug;
    data['hierarchy'] = hierarchy;
    data['url'] = url;
    data['parent'] = parent;
    data['target'] = target;
    data['color'] = color?.toJson();
    data['child'] = child;
    return data;
  }
}

class MenuColor {
  String? slug;
  String? hex;

  MenuColor({this.slug, this.hex});

  MenuColor.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    hex = json['hex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slug'] = slug;
    data['hex'] = hex;
    return data;
  }
}
