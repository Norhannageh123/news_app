import 'package:flutter/material.dart';
import 'package:news_app/Models/category_model.dart';
import 'package:news_app/provider/themeProvider.dart';
import 'package:news_app/utls/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryFragment extends StatefulWidget {
  CategoryFragment({super.key, required this.onViewAllClick});
  final Function onViewAllClick;

  @override
  State<CategoryFragment> createState() => _CategoryFragmentState();
}

class _CategoryFragmentState extends State<CategoryFragment> {
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryList = [];
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var isDarkTheme=Theme.of(context).brightness==Brightness.dark;
    categoryList = CategoryModel.getCategoriesList(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.03,
        horizontal: width * 0.03,
      ),
      child: categoryList.isEmpty
          ? Center(
              child: Text(
                "No category",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.good_morning,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: height * 0.02),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      // التحقق من وجود الصورة
                      /*
                      String? imagePath = isDarkTheme
                          ? categoryList[index].imageDarkPath
                          :categoryList[index].imageLightPath;
                          */

                      return Stack(
                        alignment: index % 2 == 0
                            ? Alignment.bottomRight
                            : Alignment.bottomLeft,
                        children: [
                           ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    Theme.of(context).brightness==Brightness.dark?
                                     categoryList[index].imageDarkPath
                                    :categoryList[index].imageLightPath,
                                   
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: height * 0.02,
                              left: width * 0.02,
                              right: width * 0.02,
                            ),
                            child: ToggleSwitch(
                              animate: true,
                              customWidths: const [90.0, 50.0],
                              cornerRadius: 40.0,
                              activeBgColors: [
                                [AppColors.greyColor, AppColors.greyColor],
                                [AppColors.greyColor, AppColors.greyColor],
                              ],
                              activeFgColor: isDarkTheme
                                  ? AppColors.blackColor
                                  : AppColors.whiteColor,
                              inactiveBgColor: isDarkTheme
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor,
                              inactiveFgColor: isDarkTheme
                                  ? AppColors.blackColor
                                  : AppColors.whiteColor,
                              totalSwitches: 2,
                              labels: [
                                AppLocalizations.of(context)!.view_all,
                                '',
                              ],
                              icons: const [
                                null,
                                Icons.arrow_forward_ios_outlined,
                              ],
                              onToggle: (index1) {
                                if (widget.onViewAllClick != null) {
                                  widget.onViewAllClick(categoryList[index]);
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: categoryList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: height * 0.02);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
