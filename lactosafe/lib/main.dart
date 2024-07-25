import 'package:LactoSafe/src/shared/app_colors.dart';
import 'package:LactoSafe/src/view/camera_view.dart';
import 'package:LactoSafe/src/view/food_list_view.dart';
import 'package:LactoSafe/src/view/begining_page_view.dart';
import 'package:LactoSafe/src/view/missing_food_registration_view.dart';
import 'package:LactoSafe/src/view/settings_page.dart';
import 'package:LactoSafe/src/view/signin_page_view.dart';
import 'package:LactoSafe/src/shared/app_settings.dart';
import 'package:LactoSafe/src/view/home_page.dart';
import 'package:LactoSafe/src/view/info_food_view.dart';
import 'package:LactoSafe/src/view/reset_password_view.dart';
import 'package:LactoSafe/src/view/missing_food_view.dart';
import 'package:LactoSafe/src/view/welcome_page_view.dart';
import 'package:flutter/material.dart';
import 'package:LactoSafe/src/view/cadastro_informações_page_view.dart';
import 'package:LactoSafe/src/view/signup_page_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettings.screenWidth = MediaQuery.of(context).size.width;
    AppSettings.screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LactoSafe',
        theme: ThemeData(
            primaryColor: AppColors.orange,
            appBarTheme: AppBarTheme(
                elevation: 0, backgroundColor: AppColors.backgroundColor),
            colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: AppColors.orange, secondary: AppColors.orange)),
        initialRoute: WelcomePage.routeName,
        routes: {
          SignIn.routeName: (context) => const SignIn(),
          ResetPassword.routeName: (context) => const ResetPassword(),
          HomePage.routeName: (context) => const HomePage(),
          InfoFoodPage.routeName: (context) => const InfoFoodPage(),
          SettingsPage.routeName: (context) => const SettingsPage(),
          FoodListView.routeName: (context) => const FoodListView(),
          CameraView.routeName: (context) => const CameraView(),
          MissingFood.routeName: (context) => const MissingFood(),
          MissingFoodRegistration.routeName: (context) =>
              const MissingFoodRegistration(),
          BeginingPage.routeName: (context) => const BeginingPage(),
          WelcomePage.routeName: (context) => const WelcomePage(),
          CadastroInformation.routeName: (context) =>
              const CadastroInformation(),
          SignUpPage.routeName: (context) => const SignUpPage(),
        });
  }
}
