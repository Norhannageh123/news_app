import 'package:flutter/material.dart';
import 'package:news_app/utls/app_styles.dart';

// ignore: must_be_immutable
class DrawerItem extends StatelessWidget {
   DrawerItem({super.key,required this.imagePath,required this.text});
  String imagePath;
  String text;
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

    return Padding(
      padding:  EdgeInsets.symmetric(
        vertical: height*0.02,
        horizontal: width*0.04,
      ),
      child: Row(
        children: [
          ImageIcon(AssetImage(imagePath)),
          SizedBox(width: width*0.02,),
          Text(text,style: AppStyles.white20bold,),
        ],
      ),
    );
  }
}