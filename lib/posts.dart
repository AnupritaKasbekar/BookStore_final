import 'dart:async';
//import 'dart:collection';
import 'package:BookStore/SearchData.dart';
//import 'package:BookStore/SearchUI.dart';
import 'package:BookStore/http_service.dart';
import 'package:flutter/material.dart';
import 'Post_model.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
//import 'SearchUI.dart';
import 'SearchData.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key}) : super(key: key);
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  SearchBar searchBar;
  Future<Post> _postData;
  var article;
  //BookSearch searchDelegatebook;
  //final StreamController _streamController = StreamController();
  List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  _PostPageState({this.suggestions, this.query, this.onSelected});

  @override
  void initState() {
    _postData = HttpService().getPosts();
    super.initState();

    //searchDelegatebook = BookSearch(SearchData.bookString);
  }

  @override
  Widget build(BuildContext context) {
    //final HttpService httpService = HttpService();
    print("BuildContext");
    return StreamBuilder(
        //MaterialApp(
        //initialData: "Working",
        builder: (context, snapshot) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Search Book'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: BookSearch(SearchData.bookString),
                );
              },
            ),
          ],
        ),
        // searchBar.build(context),
        body: Container(
          child: FutureBuilder<Post>(
            future: _postData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  //itemCount: snapshot.data,
                  itemBuilder: (context, index) {
                    article = snapshot.data.books[index];
                    return Container(
                      height: 100,
                      child: Row(
                        children: <Widget>[
                          //Text(article.title),
                          Image.network(article.image),
                        ], //<Widget>[Image.network(article.image)],
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
    });
  }
}

//class BookSearch extends SearchDelegate<String> {
class BookSearch extends SearchDelegate<List<String>> {
  List<String> books;

  BookSearch(List<String> bookString);

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                this.close(context, books);
              },
              child: Text(
                this.query,
                style: Theme.of(context)
                    .textTheme
                    // ignore: deprecated_member_use
                    .display2
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isNotEmpty
          ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
          : IconButton(
              icon: const Icon(Icons.mic),
              onPressed: () {
                this.query = "";
              }),
    ];
  }

  @override
  // ignore: missing_return
  Widget buildLeading(BuildContext context) {
    try {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {},
      );
    } catch (e) {
      print("buildLeading" + e);
    }
  }

  String selectedReault;
// _PostPageState({this.suggestions, this.query, this.onSelected});

  @override
  // ignore: missing_return
  Widget buildSuggestions(BuildContext context) {
    var article;
    SearchData.loadBookList();
    List<String> suggestions = List.from(SearchData.bookList);

    try {
      if (suggestions.contains(query)) {
        return Container(
          child: FutureBuilder<Post>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  //itemCount: snapshot.data,
                  itemBuilder: (context, index) {
                    article = snapshot.data.books[index];
                    return Container(
                      height: 100,
                      child: Row(
                        children: <Widget>[
                          Text(article.title),
                          Text(article.subtitle),
                          Image.network(article.image),
                        ], //<Widget>[Image.network(article.image)],
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      }
    } catch (e) {
      print(" in buildSuggestions Exception:" + e);
    }
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
