import 'package:flutter/material.dart';

class MySearchDelegated extends SearchDelegate {
      List<String> searchResults = [
      'Brazil',
      'China',
      'India',
      'Russia',
      'USA',
    ];
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back),
      );
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear),
        ),
      ];
  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
        ),
      );
  @override
  Widget buildSuggestions(BuildContext context) {

    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            print(suggestion); //will remove print
          },
        ); // ListTile
      },
    );
  }
}
