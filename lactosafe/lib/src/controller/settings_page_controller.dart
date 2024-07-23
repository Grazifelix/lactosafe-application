
import 'package:LactoSafe/src/model/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

logoutController(BuildContext context){
  context.read<AuthService>().logout();
}