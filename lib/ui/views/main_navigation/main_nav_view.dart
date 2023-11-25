import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skybase/ui/views/profile/profile_view.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_view.dart';
import 'package:skybase/ui/views/utils/utils_view.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';
import 'package:skybase/ui/widgets/sky_box.dart';

class MainNavView extends StatefulWidget {
  static const String route = '/home';

  const MainNavView({super.key});

  @override
  State<MainNavView> createState() => _MainNavViewState();
}

class _MainNavViewState extends State<MainNavView> {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredStatusBar.primary(
        brightness: Brightness.dark,
        child: SafeArea(
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: const [
              SampleFeatureListView(),
              UtilsView(),
              ProfileView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SkyBox(
        borderRadius: 0,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        borderColor: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 3,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.home),
              label: 'txt_users'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.slider_horizontal_3),
              label: 'txt_utility'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.profile_circled),
              label: 'txt_profile'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
