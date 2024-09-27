import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:netflixclone/models/moviemodel.dart';
import 'package:http/http.dart' as http;

class ApiOperations {
  /// fetching the all category of the data
  fetchAllMovies(BuildContext context) async {
    try {
      print("fetch All data called");
      String url = 'https://api.tvmaze.com/search/shows?q=all';
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> records = data;
        List<Moviemodel> movieList =
            records.map((json) => Moviemodel.ApiToApp(json['show'])).toList();
        print("printing movie list");
        print(movieList);
        return movieList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load data');
    }
  }

  SearchMovie(BuildContext context, String name) async {
    print("search funtion called");
    try {
      String url = "https://api.tvmaze.com/search/shows?q=${name}";
      ;
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> records = data;
        List<Moviemodel> movieList =
            records.map((json) => Moviemodel.ApiToApp(json['show'])).toList();
        print("printing movie list");
        print(movieList);
        return movieList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load data');
    }
  }
}
