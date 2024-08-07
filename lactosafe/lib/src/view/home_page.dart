import 'package:LactoSafe/src/components/photo_widget.dart';
import 'package:LactoSafe/src/shared/app_colors.dart';
import 'package:LactoSafe/src/shared/app_images.dart';
import 'package:LactoSafe/src/shared/app_settings.dart';
import 'package:LactoSafe/src/view/home_page_view.dart';
import 'package:LactoSafe/src/view/map_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List _pages = [HomePageBody(), MapPage()];
  int _indiceAtual = 0;

  void onTabTapped(int index) {
    // setState(() {
    //   _indiceAtual = index;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          automaticallyImplyLeading: false,
          toolbarHeight: AppSettings.screenHeight / 12,
          leading:
              Padding(
                padding: const EdgeInsets.only(left: .0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                            Image.asset("assets/images/lactosafe_logo_letterless.png"),
                            RichText(
                text: TextSpan(children: [
                  TextSpan(text: "Lacto",  style: TextStyle(color: AppColors.orange, fontWeight: FontWeight.w800)),
                  TextSpan(
                      text: "Safe",
                      style: TextStyle(color: AppColors.grey, fontWeight: FontWeight.w800)),
                ]),
                            )
                          ]),
              ),
          leadingWidth: 120,
        ),
        body: _pages.elementAt(_indiceAtual),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
            width: 85.0,
            height: 85.0,
            child: FittedBox(
                child: FloatingActionButton.large(
                  shape: const StadiumBorder(),
                    onPressed: () {
                      Navigator.pushNamed(context, '/camera');
                    },
                    backgroundColor: AppColors.orange,
                    child: Image.asset(AppImages.cameraIcon)))),
        bottomNavigationBar: SizedBox(
          height: 90,
          child: _getBottomNavigationBar(),
        ));
  }

  ClipRRect _getBottomNavigationBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
      child: BottomNavigationBar(
        iconSize: 30.0,
        backgroundColor: AppColors.pure_white,
        unselectedItemColor: AppColors.grey,
        selectedItemColor: AppColors.orange,
        currentIndex: _indiceAtual,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                AppImages.homeIcon,
                color: AppColors.pure_white,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Image.asset(
                AppImages.mapIcon,
                color: AppColors.pure_white,
              ),
              label: "")
        ],
      ),
    );
  }
}
