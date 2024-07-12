import 'package:LactoSafe/src/model/auth_service.dart';
import 'package:LactoSafe/src/view/home_page.dart';
import 'package:LactoSafe/src/view/signin_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});
  static const routeName = '/auth';

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isloading) {
      return loadingAnimation();
    } else if (auth.currentUser == null) {
      return const SignIn();
    } else {
      return const HomePage();
    }
  }
}

Widget loadingAnimation() {
  return const Scaffold(
    body: CircularProgressIndicator(),
  );
}
