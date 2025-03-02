class ArticlePartnersModel {
  final List<Post> posts;

  ArticlePartnersModel({required this.posts});

  factory ArticlePartnersModel.fromJson(Map<String, dynamic> json) {
    return ArticlePartnersModel(
      posts: (json['posts'] as List).map((post) => Post.fromJson(post)).toList(),
    );
  }
}

class Post {
  final int id;
  final String title;
  final String permalink;
  final String publishDate;
  final String? modifiedDate;
  final String status;
  final String partnerName;
  final String? upperText;
  final String? excerpt;
  final dynamic parent;
  final List<dynamic> tags;
  final List<dynamic> category;
  final List<dynamic> author;
  final List<dynamic> postType;
  final List<dynamic> featuredMedia;

  Post({
    required this.id,
    required this.title,
    required this.permalink,
    required this.publishDate,
    this.modifiedDate,
    required this.status,
    required this.partnerName,
    this.upperText,
    this.excerpt,
    this.parent,
    required this.tags,
    required this.category,
    required this.author,
    required this.postType,
    required this.featuredMedia,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      permalink: json['permalink'],
      publishDate: json['publish_date'],
      modifiedDate: json['modified_date'],
      status: json['status'],
      partnerName: json['partner_name'],
      upperText: json['upper_text'],
      excerpt: json['excerpt'],
      parent: json['parent'],
      tags: json['tags'] ?? [],
      category: json['category'] ?? [],
      author: json['author'] ?? [],
      postType: json['post_type'] ?? [],
      featuredMedia: json['featured_media'] ?? [],
    );
  }
}
