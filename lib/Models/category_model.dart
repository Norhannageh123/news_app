import 'package:flutter/material.dart';
import 'package:news_app/utls/app_images.dart';

class CategoryModel {
  String? id;
  String? title;
  String? imagePath;
  CategoryModel(
      {required this.id, required this.title, required this.imagePath});
  /*
  business entertainment
  general health
  science sports
  technology
  */
  static List<CategoryModel> getCategoriesList(BuildContext context) {
    return [
      CategoryModel(
          id: 'entertainment',
          title: 'Entertainment',
          imagePath: Theme.of(context).brightness == Brightness.dark
              ? AppImages.entrainmentDark
              : AppImages.entrainmentLight),
      CategoryModel(
        id: 'business',
        title: 'Business',
        imagePath: Theme.of(context).brightness == Brightness.dark
            ? AppImages.businessDark
            : AppImages.businessLight,
      ),
      CategoryModel(
        id: 'general',
        title: 'General',
        imagePath: Theme.of(context).brightness == Brightness.dark
            ? AppImages.generalDark
            : AppImages.generalLight,
            
      ),
      
      CategoryModel(
        id: 'health',
        title: 'Health',
        imagePath: Theme.of(context).brightness == Brightness.dark
            ? AppImages.healthDarj
            : AppImages.healthLight,
            
      ),
      CategoryModel(
        id: 'science',
        title: 'Science',
        imagePath: Theme.of(context).brightness == Brightness.dark
            ? AppImages.scienceDark
            : AppImages.scienceLight,
      ),
      CategoryModel(
        id: 'technology',
        title: 'Technology',
        imagePath: Theme.of(context).brightness == Brightness.dark
            ? AppImages.technologyDark
            : AppImages.technologyLight,
      ),
      CategoryModel(
        id: 'sports',
        title: 'Sports',
        imagePath: Theme.of(context).brightness == Brightness.dark
            ? AppImages.sportsDark
            : AppImages.sportsLight,
      ),
    ];
  }
}
