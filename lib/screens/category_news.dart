import 'package:flutter/material.dart';
import 'package:flutternews/helper/news.dart';
import 'package:flutternews/model/article_model.dart';

import 'article_screen.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  const CategoryNews({Key key, this.category}) : super(key: key);

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsObject = CategoryNewsClass();
    await newsObject.getNews(widget.category);
    articles = newsObject.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.save)),
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: _loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.only(top: 16.0),
                  child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) => BlogTile(
                      imageUrl: articles[index].urlToImage,
                      title: articles[index].title,
                      dec: articles[index].description,
                      url: articles[index].url,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, dec, url;

  const BlogTile(
      {Key key,
      @required this.imageUrl,
      @required this.title,
      @required this.dec,
      @required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleScreen(
              blogUrl: url,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(imageUrl),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              dec,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
