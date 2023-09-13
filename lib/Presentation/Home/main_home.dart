import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/Presentation/Home/pages/Home/Home_View/home_screen.dart';
import 'package:tut_app/Presentation/Home/pages/Notification/notification_screen.dart';
import 'package:tut_app/Presentation/Home/pages/Search/search_screen.dart';
import 'package:tut_app/Presentation/Home/pages/Settings/settings_screen.dart';
import 'package:tut_app/Presentation/Resources/color_manager.dart';
import 'package:tut_app/Presentation/Resources/language_manager.dart';
import 'package:tut_app/Presentation/Resources/string_manager.dart';
import 'package:tut_app/Presentation/Resources/values_manager.dart';

class MainScreen extends StatefulWidget {
   MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const NotificationScreen(),
    SettingsScreen()
  ];

  List<String> titles = [
    StringsManager.home,
    StringsManager.search,
    StringsManager.notification,
    StringsManager.settings
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: ColorManager.primary,
        title: Text(titles[currentIndex].tr(),style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white,fontSize: 25),),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorManager.lightGrey,
              spreadRadius: AppSizes.s1,
            )
          ]

        ),

        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: StringsManager.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: StringsManager.search.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications),
              label: StringsManager.notification.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: StringsManager.settings.tr(),
            ),
          ],
          onTap: onTab,
        ),
      )
    );
  }

  void onTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
