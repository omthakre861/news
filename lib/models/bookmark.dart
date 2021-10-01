// To parse this JSON data, do
//
//     final bookmark = bookmarkFromJson(jsonString);

import 'dart:convert';

List<Bookmark> bookmarkFromJson(String str) =>
    List<Bookmark>.from(json.decode(str).map((x) => Bookmark.fromJson(x)));

String bookmarkToJson(List<Bookmark> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bookmark {
  Bookmark({
    this.like,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  bool? like;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        like: json["like"],
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "like": like,
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt!.toIso8601String(),
        "content": content,
      };
}
