class ArticleModel {
  String? id;
  String? status;
  String? publishDate;
  String? modifiedDate;
  String? upperTitle;
  String? title;
  String? excerpt;
  String? slug;
  String? parent;
  String? permalink;
  FeaturedMedia? featuredMedia;
  List<ArticleTags>? tags;
  Category? category;
  Author? author;
  Type? postType;
  Content? content;

  ArticleModel(
      {this.id,
      this.status,
      this.publishDate,
      this.modifiedDate,
      this.upperTitle,
      this.title,
      this.excerpt,
      this.slug,
      this.parent,
      this.permalink,
      this.featuredMedia,
      this.tags,
      this.category,
      this.author,
      this.postType,
      this.content});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    publishDate = json['publish_date'];
    modifiedDate = json['modified_date'];
    upperTitle = json['upper_title'];
    title = json['title'];
    excerpt = json['excerpt'];
    slug = json['slug'];
    parent = json['parent'];
    permalink = json['permalink'];
    featuredMedia = json['featured_media'] != null
        ? FeaturedMedia.fromJson(json['featured_media'])
        : null;
    if (json['tags'] != null) {
      tags = <ArticleTags>[];
      json['tags'].forEach((v) {
        tags!.add(ArticleTags.fromJson(v));
      });
    }
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    postType =
        json['post_type'] != null ? Type.fromJson(json['post_type']) : null;
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['publish_date'] = publishDate;
    data['modified_date'] = modifiedDate;
    data['upper_title'] = upperTitle;
    data['title'] = title;
    data['excerpt'] = excerpt;
    data['slug'] = slug;
    data['parent'] = parent;
    data['permalink'] = permalink;
    if (featuredMedia != null) {
      data['featured_media'] = featuredMedia!.toJson();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (postType != null) {
      data['post_type'] = postType!.toJson();
    }
    if (content != null) {
      data['content'] = content!.toJson();
    }
    return data;
  }
}

class FeaturedMedia {
  ArticleImage? image;
  GalleryData? gallery;
  VideoData? video;

  FeaturedMedia({this.image, this.gallery, this.video});

  FeaturedMedia.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? ArticleImage.fromJson(json['image']) : null;
    gallery =
        json['gallery'] != null ? GalleryData.fromJson(json['gallery']) : null;
    video = json['video'] != null ? VideoData.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (image != null) {
      data['image'] = image!.toJson();
    }
    if (gallery != null) {
      data['gallery'] = gallery!.toJson();
    }
    if (video != null) {
      data['video'] = video!.toJson();
    }
    return data;
  }
}

class VideoData {
  String? id;
  String? type;
  String? permalink;

  VideoData({this.id, this.type, this.permalink});

  VideoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    permalink = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['permalink'] = permalink;
    return data;
  }
}

class GalleryData {
  String? id;

  GalleryData({this.id});

  GalleryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class ArticleImage {
  int? id;
  String? url;
  String? fallback;
  String? alt;
  String? title;
  String? caption;
  String? credits;
  bool? hidden;

  ArticleImage(
      {this.id,
      this.url,
      this.fallback,
      this.alt,
      this.title,
      this.caption,
      this.credits,
      this.hidden});

  ArticleImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    fallback = json['fallback'];
    alt = json['alt'];
    title = json['title'];
    caption = json['caption'];
    credits = json['credits'];
    hidden = json['hidden'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['fallback'] = fallback;
    data['alt'] = alt;
    data['title'] = title;
    data['caption'] = caption;
    data['credits'] = credits;
    data['hidden'] = hidden;
    return data;
  }
}

class ArticleTags {
  String? id;
  String? name;
  String? slug;
  bool? hidden;
  String? permalink;
  Branded? branded;
  Picture? picture;
  PartnerPicture? partnerPicture;

  ArticleTags(
      {this.id,
      this.name,
      this.slug,
      this.hidden,
      this.permalink,
      this.branded,
      this.picture,
      this.partnerPicture});

  ArticleTags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    hidden = json['hidden'];
    permalink = json['permalink'];
    branded =
        json['branded'] != null ? Branded.fromJson(json['branded']) : null;
    picture =
        json['picture'] != null ? Picture.fromJson(json['picture']) : null;
    partnerPicture = json['partnerPicture'] != null
        ? PartnerPicture.fromJson(json['partnerPicture'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['hidden'] = hidden;
    data['permalink'] = permalink;
    if (branded != null) {
      data['branded'] = branded!.toJson();
    }
    if (picture != null) {
      data['picture'] = picture!.toJson();
    }
    if (partnerPicture != null) {
      data['partnerPicture'] = partnerPicture!.toJson();
    }
    return data;
  }
}

class Branded {
  bool? enabled;
  String? permalink;

  Branded({this.enabled, this.permalink});

  Branded.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    permalink = json['permalink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enabled'] = enabled;
    data['permalink'] = permalink;
    return data;
  }
}

class Picture {
  bool? enabled;
  String? id;
  String? url;

  Picture({this.enabled, this.id, this.url});

  Picture.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enabled'] = enabled;
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}

class PartnerPicture {
  bool? partnerStatus;
  String? id;
  String? url;
  String? permalink;

  PartnerPicture({this.partnerStatus, this.id, this.url, this.permalink});

  PartnerPicture.fromJson(Map<String, dynamic> json) {
    partnerStatus = json['partnerStatus'];
    id = json['id'];
    url = json['url'];
    permalink = json['permalink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partnerStatus'] = partnerStatus;
    data['id'] = id;
    data['url'] = url;
    data['permalink'] = permalink;
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? slug;
  List<String>? hierarchy;

  Category({this.id, this.name, this.slug, this.hierarchy});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    hierarchy = json['hierarchy'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['hierarchy'] = hierarchy;
    return data;
  }
}

class Author {
  String? region;
  String? rendered;
  List<ArticleList>? list;

  Author({this.region, this.list});

  Author.fromJson(Map<String, dynamic> json) {
    region = json['region'];
    rendered = json['rendered'];
    if (json['list'] != null) {
      list = <ArticleList>[];
      json['list'].forEach((v) {
        list!.add(ArticleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['region'] = region;
    data['rendered'] = rendered;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArticleList {
  String? id;
  String? name;
  String? slug;
  String? origin;
  String? position;
  String? bio;
  String? picture;
  Social? social;
  Type? type;

  ArticleList(
      {this.id,
      this.name,
      this.slug,
      this.origin,
      this.position,
      this.bio,
      this.picture,
      this.social,
      this.type});

  ArticleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    origin = json['origin'];
    position = json['position'];
    bio = json['bio'];
    picture = json['picture'];
    social = json['social'] != null ? Social.fromJson(json['social']) : null;
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['origin'] = origin;
    data['position'] = position;
    data['bio'] = bio;
    data['picture'] = picture;
    if (social != null) {
      data['social'] = social!.toJson();
    }
    if (type != null) {
      data['type'] = type!.toJson();
    }
    return data;
  }
}

class Social {
  String? linkedin;
  String? instagram;
  String? twitter;
  String? facebook;
  String? youtube;
  String? pinterest;
  String? tiktok;

  Social(
      {this.linkedin,
      this.instagram,
      this.twitter,
      this.facebook,
      this.youtube,
      this.pinterest,
      this.tiktok});

  Social.fromJson(Map<String, dynamic> json) {
    linkedin = json['linkedin'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    youtube = json['youtube'];
    pinterest = json['pinterest'];
    tiktok = json['tiktok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['linkedin'] = linkedin;
    data['instagram'] = instagram;
    data['twitter'] = twitter;
    data['facebook'] = facebook;
    data['youtube'] = youtube;
    data['pinterest'] = pinterest;
    data['tiktok'] = tiktok;
    return data;
  }
}

class Type {
  String? name;
  String? slug;

  Type({this.name, this.slug});

  Type.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }
}

class Content {
  String? type;
  String? content;
  String? encoded;

  Content({this.type, this.content, this.encoded});

  Content.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    content = json['content'];
    encoded = json['encoded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['content'] = content;
    data['encoded'] = encoded;
    return data;
  }
}
