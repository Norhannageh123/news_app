import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:news_app/ApI/api_constants.dart';
import 'package:news_app/ApI/endpoints.dart';
import 'package:news_app/Models/NewsResponse.dart';
import 'package:news_app/Models/sourseResponce.dart';
@Singleton()
class ApiManager{
  ApiManager._();
  static ApiManager? _instance;
  static ApiManager getInstance() {
    _instance ??= ApiManager._();
    return _instance!;
  }
   Future<SourceResponse?> getSources(String categoryId, String language) async {
  Uri url = Uri.https(
    ApiConstants.baseUrl,
    Endpoints.sourceApi,
    {
      'apiKey': ApiConstants.apiKey,
      'category': categoryId,
      'language': language,  
    }
  );
  try {
    var response = await http.get(url);
    var bodyResponse = response.body;
    var json = jsonDecode(bodyResponse);
    return SourceResponse.fromJson(json);
  } catch (e) {
    throw e;
  }
}

 Future<NewsResponse?> getNewsBySourceId(
  String sourceId,
  String language,
  int page,
) async {
  Uri url = Uri.https(
    ApiConstants.baseUrl,
    Endpoints.newsApi,
    {
      'apiKey': ApiConstants.apiKey,
      'sources': sourceId,
      'language': language,
      'page': page.toString(), 
      
    },
  );
  try {
    var response = await http.get(url);
    var responseBody = response.body;
    var json = jsonDecode(responseBody);
    return NewsResponse.fromJson(json);
  } catch (e) {
    throw e;
  }
}


}