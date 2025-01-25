import 'package:flutter/material.dart';
import 'package:news_app/utls/app_images.dart';

class CategoryModel {
  String id;
  String title;
  String imagePath;
  CategoryModel(
      {required this.id, required this.title, required this.imagePath});
  /*
  business entertainment
  general health
  science sports
  technology
  */
  static List<CategoryModel> getCategoriesList(
      BuildContext context,isDark) {
    return [
      CategoryModel(
          id: 'entertainment',
          title: 'Entertainment',
          imagePath: isDark?AppImages.entrainmentLight:AppImages.entrainmentDark,
          ),
      CategoryModel(
        id: 'business',
        title: 'Business',
         imagePath: isDark?AppImages.businessLight:AppImages.businessDark,
      ),
      CategoryModel(
        id: 'general',
        title: 'General',
         imagePath: isDark?AppImages.generalLight:AppImages.generalDark,
      ),
      CategoryModel(
          id: 'health',
          title: 'Health',
          imagePath: isDark?AppImages.healthLight:AppImages.healthDarj,
         ),
      CategoryModel(
          id: 'science',
          title: 'Science',
           imagePath: isDark?AppImages.scienceLight:AppImages.scienceDark,
         ),
      CategoryModel(
          id: 'technology',
          title: 'Technology',
           imagePath: isDark?AppImages.technologyLight:AppImages.technologyDark,
         ),
      CategoryModel(
          id: 'sports',
          title: 'Sports',
           imagePath: isDark?AppImages.sportsLight:AppImages.sportsDark,
          ),
    ];
  }
}
