import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/ArticleModel.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/category_news.dart';
import 'package:news_app/widgets/category_tile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> article = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsObj = News();
    await newsObj.getNews();
    article = newsObj.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter".toUpperCase()),
            Text(
              "News".toUpperCase(),
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  // Categories
                  Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap:
                          true, // by default listview try to occupy all the space of parent
                      //  by shrikwrap to true it occupy only that much space that it need
                      //  and if required more become scrollable
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CategoryTile(
                          categoryName: categories[index].categoryName,
                          imageUrl: categories[index].imageUrl),
                    ),
                  ),

                  // Articles
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height -
                          130 -
                          AppBar().preferredSize.height,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: article.length,
                          itemBuilder: (context, index) {
                            return ArticleTile(
                              imageUrl: article[index].urlToImage,
                              title: article[index].title,
                              desc: article[index].description,
                              url: article[index].url,
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}


