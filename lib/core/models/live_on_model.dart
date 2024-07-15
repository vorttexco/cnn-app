class LiveOnModel {
  Live? live;
  List<Next>? next;

  LiveOnModel({this.live, this.next});

  LiveOnModel.fromJson(Map<String, dynamic> json) {
    live = json['live'] == null ? null : Live.fromJson(json['live']);
    next = (json['next'] as List).map((e) => Next.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['live'] = live?.toJson();
    data['next'] = next?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Next {
  String? title;
  String? description;
  String? logo;
  String? presenter;
  String? startTime;
  String? endTime;
  Video1? video;

  Next(
      {this.title,
      this.description,
      this.logo,
      this.presenter,
      this.startTime,
      this.endTime,
      this.video});

  Next.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    logo = json['logo'];
    presenter = json['presenter'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    video = json['video'] == null ? null : Video1.fromJson(json['video']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['logo'] = logo;
    data['presenter'] = presenter;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['video'] = video?.toJson();
    return data;
  }
}

class Video1 {
  String? type;
  String? id;
  String? permalink;

  Video1({this.type, this.id, this.permalink});

  Video1.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    permalink = json['permalink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['permalink'] = permalink;
    return data;
  }
}

class Live {
  String? title;
  String? description;
  String? logo;
  String? presenter;
  String? startTime;
  String? endTime;
  Video? video;

  Live(
      {this.title,
      this.description,
      this.logo,
      this.presenter,
      this.startTime,
      this.endTime,
      this.video});

  Live.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    logo = json['logo'];
    presenter = json['presenter'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    video = json['video'] == null ? null : Video.fromJson(json['video']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['logo'] = logo;
    data['presenter'] = presenter;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['video'] = video?.toJson();
    return data;
  }
}

class Video {
  String? type;
  String? id;
  String? permalink;

  Video({this.type, this.id, this.permalink});

  Video.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    permalink = json['permalink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['permalink'] = permalink;
    return data;
  }
}
