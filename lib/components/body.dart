import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/components/category_tile.dart';
import 'package:flutternews/model/article_model.dart';
import 'package:flutternews/screens/article_screen.dart';
import '../model/category_model.dart';

class Body extends StatelessWidget {
  const Body({Key key, @required this.categories, @required this.articles})
      : super(key: key);

  final List<CategoryModel> categories;
  final List<ArticleModel> articles;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              height: 70.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) => CategoryTile(
                  imageUrl: categories[index].imageUrl,
                  categorysName: categories[index].categoryName,
                ),
              ),
            ),

            /// blogs
            Container(
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
            )
          ],
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
