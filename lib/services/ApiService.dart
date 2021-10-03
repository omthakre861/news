import 'package:http/http.dart' as http;
import 'package:news/models/categornews.dart';
import 'package:news/models/newsheadline.dart';
import 'package:news/models/search.dart';
import 'package:news/services/Apiconfig.dart';
 
  late String apikey = ApiConfig.API_KEY;
class ApiService {
  
 
  static var client = http.Client();

  static Future<NewsHeadline?> fetchNewsHeadline() async {
    var url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apikey";
    var response = await client.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        NewsHeadline? newsheadlineinfo = newsHeadlineFromJson(jsonString);
        return newsheadlineinfo;
      }
    } catch (e) {
      print(e);
      // TODO
    }
    return null;
  }
}

class CategoryService {
  static var client = http.Client();

  static Future<CategoryNews?> fetchCategory(String catergoryname) async {
    var url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$catergoryname&apiKey=$apikey";
    var response = await client.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        CategoryNews? categoryinfo = categoryNewsFromJson(jsonString);
        return categoryinfo;
      }
    } catch (e) {
      print(e);
      // TODO
    }
    return null;
  }
}

class SearchService {
  static var client = http.Client();

  static Future<SearchNews?> fetchSearch(String query, String sortby) async {
    var url =
        "https://newsapi.org/v2/everything?q=$query&sortBy=$sortby&apiKey=$apikey";
    var response = await client.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        SearchNews? searchinfo = searchNewsFromJson(jsonString);
        return searchinfo;
      }
    } catch (e) {
      print(e);
      // TODO
    }
    return null;
  }
}
