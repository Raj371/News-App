import 'package:flutter/material.dart';
import 'package:news_app/views/article_view.dart';

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
