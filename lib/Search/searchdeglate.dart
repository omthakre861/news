import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Searchpage extends SearchDelegate<String> {
  @override
  // TODO: implement keyboardType


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            // print(query);
            close(context, query);
          },
          icon: Icon(CupertinoIcons.search))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          query = "";
        
          close(context, query);
        },
        icon: Icon(CupertinoIcons.back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }
}
