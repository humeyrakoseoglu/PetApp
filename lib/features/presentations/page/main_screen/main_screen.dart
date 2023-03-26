import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

import '../../../../const.dart';
import '../activity/activity_page.dart';
import '../home/home_page.dart';
import '../post/upload_post_page.dart';
import '../profile/profile_page.dart';
import '../search/search_page.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: backGroundColor,
        items: [
          BottomNavigationBarItem(icon: Icon(MaterialCommunityIcons.home_variant, color: primaryColor), label: ""),
          BottomNavigationBarItem(icon: Icon(Ionicons.md_search, color: primaryColor), label: ""),
          BottomNavigationBarItem(icon: Icon(Ionicons.md_add_circle, color: primaryColor), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite, color: primaryColor), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined, color: primaryColor), label: ""),

        ],
        onTap: navigationTapped,
      ),
      body: PageView(
        controller: pageController,
        children: [
          HomePage(),
          SearchPage(),
          UploadPostPage(),
          ActivityPage(),
          ProfilePage()
        ],
        onPageChanged: onPageChanged,
      ),
    );
  }
}