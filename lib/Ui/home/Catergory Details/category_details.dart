import 'package:flutter/material.dart';
import 'package:news_app/ApI/api_manager.dart';
import 'package:news_app/Models/category_model.dart';
import 'package:news_app/Models/sourseResponce.dart';
import 'package:news_app/Ui/home/Catergory%20Details/tabBarWidget.dart';
import 'package:news_app/provider/languageProvider.dart';
import 'package:news_app/utls/app_colors.dart';
import 'package:news_app/utls/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoryDetails extends StatefulWidget {
  CategoryDetails({super.key, required this.category});
  CategoryModel? category;

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  late Future<SourseResponce?> futureSources = Future.value(null);

  late String currentLanguage;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
      currentLanguage = languageProvider.appLanguage;

      setState(() {
        futureSources = ApiManager.getSources(widget.category?.id ?? "", currentLanguage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    currentLanguage = languageProvider.appLanguage;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    var isDarkTheme = theme.brightness == Brightness.dark;
    final appLocalizations = AppLocalizations.of(context);

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: FutureBuilder<SourseResponce?>(
        future: futureSources,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: isDarkTheme ? AppColors.whiteColor : AppColors.greyColor,
              ),
            );
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_outlined,
                      color: AppColors.redColor,
                      size: 40,
                    ),
                    SizedBox(width: width * 0.03),
                    Text(
                      appLocalizations!.something_went_wrong,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Image.asset(
                      AppImages.error,
                      height: height * 0.3,
                      width: width * 0.2,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.redColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.02),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () {
                        setState(() {
                          futureSources = ApiManager.getSources(widget.category?.id ?? "", currentLanguage);
                        });
                      },
                      child: Text(
                        appLocalizations.try_again,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (snapshot.hasData && snapshot.data!.status != "ok") {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_outlined,
                      color: AppColors.redColor,
                      size: 40,
                    ),
                    SizedBox(width: width * 0.03),
                    Text(
                      snapshot.data!.message ?? appLocalizations!.something_went_wrong,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Image.asset(
                      AppImages.error,
                      height: height * 0.3,
                      width: width * 0.2,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.redColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.02),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () {
                        setState(() {
                          futureSources = ApiManager.getSources(widget.category?.id ?? "", currentLanguage);
                        });
                      },
                      child: Text(
                        appLocalizations!.try_again,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          var sourceList = snapshot.data!.sources ?? [];
          return TabBarCategory(sourceList: sourceList);
        },
      ),
    );
  }
}
