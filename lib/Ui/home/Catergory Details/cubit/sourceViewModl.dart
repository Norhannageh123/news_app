import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/ApI/api_manager.dart';
import 'package:news_app/Ui/home/Catergory%20Details/cubit/sourceState.dart';

class SourceViewModel extends Cubit<SourceState>{
    SourceViewModel():super(SourceLoadingState());
      void getSources(String categoryId, currentLanguage)async{
        try{
          emit(SourceLoadingState());
       var response= await ApiManager.getSources(categoryId, currentLanguage);
        if(response?.status=="error"){
          emit(SourceErrorState(errorMessage: response!.message!));
          return ;

        }
        if(response?.status=="ok"){
              emit(SourceSuccessState(sourceList: response!.sources!));
              return;
        }
        }catch(e){
          emit(SourceErrorState(errorMessage: e.toString()));
        }
        
      }
}