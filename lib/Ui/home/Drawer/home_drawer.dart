import 'package:flutter/material.dart';
import 'package:news_app/Ui/home/Drawer/category_widget.dart';
import 'package:news_app/Ui/home/Drawer/drawer_item.dart';
import 'package:news_app/Ui/home/Drawer/switch_widget.dart';
import 'package:news_app/provider/languageProvider.dart';
import 'package:news_app/utls/app_colors.dart';
import 'package:news_app/utls/app_images.dart';
import 'package:news_app/utls/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({super.key, required this.onDrawerClicked});
  Function onDrawerClicked;

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context, listen: true);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: height * 0.20,
          width: double.infinity,
          color: AppColors.whiteColor,
          child: Text(AppLocalizations.of(context)!.news_app,
              style: AppStyles.black24bold),
        ),
        InkWell(
          onTap: () {
            widget.onDrawerClicked();
            setState(() {});
          },
          child: DrawerItem(
            imagePath: AppImages.home,
            text: AppLocalizations.of(context)!.go_to_home,
          ),
        ),
        Divider(
          color: AppColors.whiteColor,
          thickness: 2,
          indent: width * 0.06,
          endIndent: width * 0.06,
        ),
        DrawerItem(
          imagePath: AppImages.theme,
          text: AppLocalizations.of(context)!.theme,
        ),
        CategoryWidget(
          text: AppLocalizations.of(context)!.dark,
        ),
        Divider(
          color: AppColors.whiteColor,
          thickness: 2,
          indent: width * 0.06,
          endIndent: width * 0.06,
        ),
        DrawerItem(
          imagePath: AppImages.language,
          text: AppLocalizations.of(context)!.language,
        ),
        SwitchWidget(
          text1: AppLocalizations.of(context)!.arabic,
          text2: AppLocalizations.of(context)!.english,
          onClicked: () {
            String newLanguage =
                languageProvider.appLanguage == 'en' ? 'ar' : 'en';
            languageProvider.changeLanguage(newLanguage);
          },
        ),
      ],
    );
  }
}
