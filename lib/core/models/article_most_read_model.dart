class ArticleMostReadModel {
  final List<Post> posts;

  ArticleMostReadModel({required this.posts});

  factory ArticleMostReadModel.fromJson(Map<String, dynamic> json) {
    return ArticleMostReadModel(
      posts: (json['posts'] as List).map((post) => Post.fromJson(post)).toList(),
    );
  }
}

class Post {
  final int id;
  final String status;
  final String publishDate;
  final String modifiedDate;
  final String title;
  final String excerpt;
  final String slug;
  final String permalink;
  final FeaturedMedia featuredMedia;
  final List<Tag> tags;
  final Category category;
  final Author author;
  final PostType postType;

  Post({
    required this.id,
    required this.status,
    required this.publishDate,
    required this.modifiedDate,
    required this.title,
    required this.excerpt,
    required this.slug,
    required this.permalink,
    required this.featuredMedia,
    required this.tags,
    required this.category,
    required this.author,
    required this.postType,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      status: json['status'],
      publishDate: json['publish_date'],
      modifiedDate: json['modified_date'],
      title: json['title'],
      excerpt: json['excerpt'],
      slug: json['slug'],
      permalink: json['permalink'],
      featuredMedia: FeaturedMedia.fromJson(json['featured_media']),
      tags: (json['tags'] as List).map((tag) => Tag.fromJson(tag)).toList(),
      category: Category.fromJson(json['category']),
      author: Author.fromJson(json['author']),
      postType: PostType.fromJson(json['post_type']),
    );
  }
}

class FeaturedMedia {
  final ImageData image;

  FeaturedMedia({required this.image});

  factory FeaturedMedia.fromJson(Map<String, dynamic> json) {
    return FeaturedMedia(image: ImageData.fromJson(json['image']));
  }
}

class ImageData {
  final int id;
  final String url;
  final String fallback;
  final String title;
  final String caption;

  ImageData({
    required this.id,
    required this.url,
    required this.fallback,
    required this.title,
    required this.caption,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      url: json['url'],
      fallback: json['fallback'],
      title: json['title'],
      caption: json['caption'],
    );
  }
}

class Tag {
  final String id;
  final String name;
  final String slug;
  final String permalink;

  Tag({required this.id, required this.name, required this.slug, required this.permalink});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      permalink: json['permalink'],
    );
  }
}

class Category {
  final int id;
  final String name;
  final String slug;

  Category({required this.id, required this.name, required this.slug});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class Author {
  final String region;
  final List<AuthorDetail> list;

  Author({required this.region, required this.list});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      region: json['region'],
      list: (json['list'] as List).map((author) => AuthorDetail.fromJson(author)).toList(),
    );
  }
}

class AuthorDetail {
  final String id;
  final String name;
  final String slug;

  AuthorDetail({required this.id, required this.name, required this.slug});

  factory AuthorDetail.fromJson(Map<String, dynamic> json) {
    return AuthorDetail(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class PostType {
  final String name;
  final String slug;

  PostType({required this.name, required this.slug});

  factory PostType.fromJson(Map<String, dynamic> json) {
    return PostType(
      name: json['name'],
      slug: json['slug'],
    );
  }
}