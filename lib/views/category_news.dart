import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/ArticleModel.dart';
import 'package:news_app/views/article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass categoryNewsObj = CategoryNewsClass();
    await categoryNewsObj.getNews(widget.category);
    article = categoryNewsObj.news;
    setState(() {
      _loading = false;
    });
  }

  List<ArticleModel> article = new List<ArticleModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${widget.category}'.toUpperCase()),
            Text(
              "News".toUpperCase(),
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
            child: Container(
                child: Column(
                  children: [
                    Container(
                      // height: MediaQuery.of(context).size.height -
          
                      //     AppBar().preferredSize.height,
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
                  ],
                ),
              ),
          ),
    );
  }
}

class ArticleTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  ArticleTile({this.imageUrl, this.title, this.desc, @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl)),
            SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 6),
            Text(
              desc,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
