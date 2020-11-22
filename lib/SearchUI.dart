import 'package:flutter/material.dart';
import 'dart:convert' show json, utf8;
import 'dart:io';
import 'dart:async';
import 'package:BookStore/Post_model.dart';
import 'posts.dart';

class Search {
  final String titlefromSearch;
  final String authorfromSearch;
  final String IsbnfromSearch;

  Search({this.IsbnfromSearch, this.authorfromSearch, this.titlefromSearch});

  List<Search> loadSearchItem() {
    var f1 = <Search>[
      Search(
          titlefromSearch: 'search by title of the book',
          authorfromSearch: 'search by author of the book',
          IsbnfromSearch: 'search by Isbn number of the book'),
      Search(
          titlefromSearch: 'search by title of the book',
          authorfromSearch: 'search by author of the book',
          IsbnfromSearch: 'search by Isbn number of the book'),
      Search(
          titlefromSearch: 'search by title of the book',
          authorfromSearch: 'search by author of the book',
          IsbnfromSearch: 'search by Isbn number of the book'),
    ];
    return f1;
  }
  /*static final HttpClient _httpClient = HttpClient();
  static final String _url = "https://api.itbook.store/1.0/search/mongodb";

  static Future<List<Post>> getRepositoriesWithSearchQuery(String query) async {
    final url = Uri.http(_url, '/search');*/

}
