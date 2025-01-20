import 'package:flutter/material.dart';
import 'package:news_app/utls/app_images.dart';

class CategoryModel {
  String id;
  String title;
  String imageLightPath;
  String imageDarkPath;
  CategoryModel(
      {required this.id, required this.title, required this.imageLightPath,required this.imageDarkPath});
  /*
  business entertainment
  general health
  science sports
  technology
  */
  static List<CategoryModel> getCategoriesList(
      BuildContext context) {
    return [
      CategoryModel(
          id: 'entertainment',
          title: 'Entertainment',
          imageLightPath: AppImages.entrainmentLight,
          imageDarkPath : AppImages.entrainmentDark
          ),
      CategoryModel(
        id: 'business',
        title: 'Business',
        imageLightPath: AppImages.businessLight,
        imageDarkPath : AppImages.businessDark,
      ),
      CategoryModel(
        id: 'general',
        title: 'General',
        imageLightPath: AppImages.generalLight,
        imageDarkPath : AppImages.generalDark,
      ),
      CategoryModel(
          id: 'health',
          title: 'Health',
          imageLightPath: AppImages.healthLight,
          imageDarkPath : AppImages.healthDarj),
      CategoryModel(
          id: 'science',
          title: 'Science',
          imageLightPath: AppImages.scienceLight,
          imageDarkPath: AppImages.scienceDark),
      CategoryModel(
          id: 'technology',
          title: 'Technology',
          imageLightPath: AppImages.technologyLight,
          imageDarkPath : AppImages.technologyDark),
      CategoryModel(
          id: 'sports',
          title: 'Sports',
          imageLightPath: AppImages.sportsLight,
          imageDarkPath : AppImages.sportsDark),
    ];
  }
}
