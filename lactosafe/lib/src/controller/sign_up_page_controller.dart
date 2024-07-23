
import 'package:LactoSafe/src/model/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<String> singUpController(BuildContext context, String email, String password) async{
  try {
    await context.read<AuthService>().signUp(email, password);
    return '';
  } on AuthException catch (e) {
    return e.message;
  }
}

