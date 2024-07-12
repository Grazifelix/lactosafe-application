import 'package:LactoSafe/src/model/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';



Future<String> signInController(BuildContext context, String email, String password) async{
  try {
    await context.read<AuthService>().signIn(email, password);
    return '';
  }on AuthException catch (e) {
    return e.message;
  }
}
