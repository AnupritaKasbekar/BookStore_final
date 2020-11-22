// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/foundation.dart';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    this.error,
    this.total,
    this.books,
  });

  String error;
  String total;
  List<Book> books;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        error: json["error"],
        total: json["total"],
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "total": total,
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
      };
}

class Book {
  Book({
    this.title,
    this.subtitle,
    this.isbn13,
    this.price,
    this.image,
    this.url,
  });

  String title;
  String subtitle;
  String isbn13;
  Price price;
  String image;
  String url;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        title: json["title"],
        subtitle: json["subtitle"],
        isbn13: json["isbn13"],
        price: priceValues.map[json["price"]],
        image: json["image"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "isbn13": isbn13,
        "price": priceValues.reverse[price],
        "image": image,
        "url": url,
      };
}

enum Price { THE_000, THE_9008, THE_3399 }

final priceValues = EnumValues({
  "\u00240.00": Price.THE_000,
  "\u002433.99": Price.THE_3399,
  "\u002490.08": Price.THE_9008
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
