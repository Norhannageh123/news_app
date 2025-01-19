import 'package:flutter/material.dart';
import 'package:news_app/Models/category_model.dart';
import 'package:news_app/Ui/home/Catergory%20Details/categor_fragment.dart';
import 'package:news_app/Ui/home/Catergory%20Details/category_details.dart';
import 'package:news_app/Ui/home/Drawer/home_drawer.dart';
import 'package:news_app/provider/languageProvider.dart';
import 'package:news_app/utls/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);  
    String currentLanguage = languageProvider.appLanguage;  
    return Scaffold(
       appBar: AppBar(
         title: Text(
          selectedCategory==null ?
          AppLocalizations.of(context)!.home: selectedCategory!.title??"",
         style:Theme.of(context).textTheme.labelLarge),
       ),
       drawer: Drawer(
        backgroundColor: AppColors.blackColor,
        child:  HomeDrawer(onDrawerClicked: onDrawerClicked,),
       ),
      body: selectedCategory==null?
      CategoryFragment(onViewAllClick:onViewAllClick ,):
       CategoryDetails(category: selectedCategory!,)
,
    );
  }
  CategoryModel? selectedCategory;
  void onViewAllClick(CategoryModel newSelectedCategory){
      selectedCategory=newSelectedCategory;
      setState(() {
        
      });
  }

 void  onDrawerClicked() {
  selectedCategory=null;
  Navigator.of(context).pop();
  setState(() {
    
  });
  }
}