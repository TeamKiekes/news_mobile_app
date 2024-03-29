import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_mobile_app/screens/models/article_model.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url = "http://10.0.2.2:8000/feed/belgium";

    var response = await http.get(url);
    // Specify utf-8 encoding because this is not present in the repsonse header
    // "content-type" and it will use "latin1" by default.
    response.headers['content-type'] += '; charset=utf-8';
    var jsonData = jsonDecode(response.body);

    jsonData.forEach((element) {
      ArticleModel articleModel = ArticleModel(
          title: element['title'],
          summary: element['summary'],
          link: element['link'],
          newsRating: element['news_rating'],
          imageUrl: element['image_url']);

      news.add(articleModel);
    });
  }
}

// class NewsForCategory {
//   List<ArticleModel> news = [];

//   Future<void> getCategoryNews(String category) async {
//     var apiKeyJson = jsonDecode("../auth/secrets.json");
//     String apiKey = apiKeyJson['api_key'];
//     String url =
//         "https://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey=$apiKey";

//     var response = await http.get(url);

//     var jsonData = jsonDecode(response.body);

//     if (jsonData['status'] == 'ok') {
//       jsonData['articles'].forEach((element) {
//         if (element['urlToImage'] != null && element['description'] != null) {
//           ArticleModel articleModel = ArticleModel(
//             title: element['title'],
//             author: element['author'],
//             description: element['description'],
//             url: element['url'],
//             urlToImage: element['urlToImage'],
//             content: element['context'],
//           );

//           news.add(articleModel);
//         }
//       });
//     }
//   }
// }
