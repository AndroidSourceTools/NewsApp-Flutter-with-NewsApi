import 'package:flutter/material.dart';
import 'package:flutternews/helper/data.dart';
import 'package:flutternews/components/body.dart';
import 'package:flutternews/helper/news.dart';
import 'package:flutternews/model/article_model.dart';
import 'package:flutternews/model/category_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsObject = News();
    await newsObject.getNews();
    articles = newsObject.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )

          /// Categories
          : Body(
              categories: categories,
              articles: articles,
            ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Flutter"),
          Text(
            "News",
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
      centerTitle: true,
      elevation: 0,
    );
  }
}
