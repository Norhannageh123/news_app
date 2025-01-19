import 'package:flutter/material.dart';
import 'package:news_app/utls/app_colors.dart';
import 'package:news_app/utls/app_styles.dart';

// ignore: must_be_immutable
class CategoryWidget extends StatelessWidget {
   CategoryWidget({super.key,required this.text});
 String text;
  @override
  Widget build(BuildContext context) {
     var height=MediaQuery.of(context).size.height;
     var width=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width*0.04,
        vertical: height*0.01,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: width*0.04,
        vertical: height*0.01,
      ),
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.whiteColor,
          width: 2,
        ),
      ) ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
             Text(text,style: AppStyles.white20Medium,),
             Icon(Icons.arrow_drop_down,size: 30,color: AppColors.whiteColor,)
        ],
      ),
    );
  }
}