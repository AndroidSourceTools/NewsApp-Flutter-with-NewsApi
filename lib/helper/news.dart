import 'dart:convert';
import 'package:flutternews/model/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  String url =
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=3998eb8eb95b4e8484f909254aa8e9db";

  Future<void> getNews() async {
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            content: element["content"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey=3998eb8eb95b4e8484f909254aa8e9db";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            content: element["content"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
