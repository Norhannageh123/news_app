import 'package:flutter/material.dart';
import 'package:news_app/Models/sourseResponce.dart';
import 'package:news_app/Ui/home/Catergory%20Details/sourceName_widget.dart';
import 'package:news_app/Ui/home/news/newsWidget.dart';
import 'package:news_app/utls/app_colors.dart';

// ignore: must_be_immutable
class TabBarCategory extends StatefulWidget {
  TabBarCategory({super.key, required this.sourceList});
  List<Source> sourceList;

  @override
  State<TabBarCategory> createState() => _TabBarCategoryState();
}

class _TabBarCategoryState extends State<TabBarCategory> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // التحقق من وجود عناصر في القائمة
    if (widget.sourceList.isEmpty) {
      return Center(
        child: Text('No sources available'), // رسالة إذا كانت القائمة فارغة
      );
    }

    return Column(
      children: [
        DefaultTabController(
          length: widget.sourceList.length,
          child: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: Theme.of(context).indicatorColor,
            dividerColor: AppColors.transparent,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            tabs: widget.sourceList.map((source) {
              return SourcenameWidget(
                source: source,
                isSelected: selectedIndex == widget.sourceList.indexOf(source),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: widget.sourceList.isNotEmpty
              ? NewsWidget(source: widget.sourceList[selectedIndex])
              : Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}
