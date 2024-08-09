import 'package:LactoSafe/src/components/photo_widget.dart';
import 'package:LactoSafe/src/controller/camera_controller.dart';
import 'package:LactoSafe/src/shared/app_camera_source.dart';
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
  static const List _pages = [HomePageBody()];
  int _indiceAtual = 0;

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
                  TextSpan(text: "LactoSafe",  style: TextStyle(color: AppColors.grey, fontWeight: FontWeight.w800)),
                  TextSpan(
                      text: " (Beta v1.0)",
                      style: TextStyle(color: AppColors.orange, fontWeight: FontWeight.w200)),
                ]),
                            )
                          ]),
              ),
          leadingWidth: 200,
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
                      // Navigator.pushNamed(context, '/camera');
                    CameraFoodPicture().takePicture(context: context, sourceType: CameraSource.camera);
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
        onTap: (int index) {
          switch (index) {
            case 0:
              GalleryFoodPicture().takePicture(
                    context: context, sourceType: CameraSource.gallery);
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                AppImages.galleryIcon,
                color: AppColors.orange,
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
