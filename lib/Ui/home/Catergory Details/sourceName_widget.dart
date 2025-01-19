import 'package:flutter/material.dart';
import 'package:news_app/Models/sourseResponce.dart';
// ignore: must_be_immutable
class SourcenameWidget extends StatelessWidget {
 SourcenameWidget({super.key,required this.source,required this.isSelected});
  Source source;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Text(
      source.name??'',
      style: isSelected?
      Theme.of(context).textTheme.headlineLarge:Theme.of(context).textTheme.headlineMedium,);
  }
}