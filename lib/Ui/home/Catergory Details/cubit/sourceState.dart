import 'package:news_app/Models/sourseResponce.dart';

abstract class SourceState {}
class SourceInitialState extends SourceState{}
class SourceLoadingState extends SourceState{}
class SourceErrorState extends SourceState{
  String? errorMessage;
  SourceErrorState({required this.errorMessage});
}
class SourceSuccessState extends SourceState{
  List<Source>? sourceList;
  SourceSuccessState({required this.sourceList});
    
}