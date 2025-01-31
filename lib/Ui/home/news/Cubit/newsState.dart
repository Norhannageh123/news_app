import 'package:news_app/Models/NewsResponse.dart';

abstract class NewsState {}
class NewsLoadingState extends NewsState{}
class NewsErrorState extends NewsState{
  String? errorMessage;
  NewsErrorState({required this.errorMessage});
}
class NewsSuccessState extends NewsState {
  final List<dynamic> newsList;
  final bool hasMore;

  NewsSuccessState({required this.newsList, this.hasMore = true});
}