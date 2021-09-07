import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/ArticleModel.dart';

class News {
  List<ArticleModel> news = new List<ArticleModel>();

  Future<void> getNews() async {
    
    String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=ba53b58ce6b04d62b1fbc5e3c71a2316";
  
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok'){
      jsonData['articles'].forEach((element) {
        if(element['urlToImage'] != null && element['description'] != null && element['title'] != null){
            ArticleModel articleModel = new ArticleModel(
            author: element['author'],
            title: element['title'],
            description: element['description'],
            url:element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            publishedAt: DateTime.parse(element['publishedAt']),
          );
           news.add(articleModel);
        }
       
      });
    } 
  }

}

class CategoryNewsClass {
  List<ArticleModel> news = new List<ArticleModel>();

  Future<void> getNews(String category) async {
    
    String url = "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=ba53b58ce6b04d62b1fbc5e3c71a2316";
  
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok'){
      jsonData['articles'].forEach((element) {
        if(element['urlToImage'] != null && element['description'] != null && element['title'] != null){
            ArticleModel articleModel = new ArticleModel(
            author: element['author'],
            title: element['title'],
            description: element['description'],
            url:element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            publishedAt: DateTime.parse(element['publishedAt']),
          );
           news.add(articleModel);
        }
       
      });
    } 
  }

}
