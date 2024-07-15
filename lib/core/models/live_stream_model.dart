class LiveStreamModel {
  String? id;
  String? type;
  String? duration;
  String? channelId;
  String? title;
  String? description;
  String? publishDate;
  String? views;
  String? likes;
  String? permalink;
  List<String>? tags;
  Thumbnail? thumbnail;

  LiveStreamModel(
      {this.id,
      this.type,
      this.duration,
      this.channelId,
      this.title,
      this.description,
      this.publishDate,
      this.views,
      this.likes,
      this.permalink,
      this.tags,
      this.thumbnail});

  LiveStreamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    duration = json['duration'];
    channelId = json['channel_id'];
    title = json['title'];
    description = json['description'];
    publishDate = json['publish_date'];
    views = json['views'];
    likes = json['likes'];
    permalink = json['permalink'];
    tags = List<String>.from(json['tags']);
    thumbnail = json['thumbnail'] == null
        ? null
        : Thumbnail.fromJson(json['thumbnail']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['duration'] = duration;
    data['channel_id'] = channelId;
    data['title'] = title;
    data['description'] = description;
    data['publish_date'] = publishDate;
    data['views'] = views;
    data['likes'] = likes;
    data['permalink'] = permalink;
    data['tags'] = tags;
    data['thumbnail'] = thumbnail?.toJson();
    return data;
  }
}

class Thumbnail {
  String? max;
  String? sd;
  String? hq;
  String? mq;

  Thumbnail({this.max, this.sd, this.hq, this.mq});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    max = json['max'];
    sd = json['sd'];
    hq = json['hq'];
    mq = json['mq'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['max'] = max;
    data['sd'] = sd;
    data['hq'] = hq;
    data['mq'] = mq;
    return data;
  }
}
