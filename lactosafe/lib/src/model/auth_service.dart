import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? currentUser;
  bool isloading = true;

  AuthService(){
    _authCheck();
  }

  _authCheck(){
    _auth.authStateChanges().listen((User? user){
      currentUser = (user == null) ? null : user;
      isloading = false;
      notifyListeners();
    });
  }

  _getUser(){
    currentUser = _auth.currentUser;
    notifyListeners();
  }

  signUp(String email, String password) async{
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if(e.code == 'weak-password'){
        throw AuthException('A senha é muito fraca');
      } else if(e.code == 'email-already-in-use'){
        throw AuthException('Email já cadastrado');
      } else {
        throw AuthException('erro ao cadastrar usuário');
      }
    }
  }

  signIn(String email, String password) async{
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found' || e.code == 'wrong-password'){
        throw AuthException('Email ou senha incorretos');
      } else{
        throw AuthException('Houve um erro ao tentar entrar na conta, tente novamente mais tarde');
      }
    }
  }

  logout() async{
    _auth.signOut();
    _getUser();
  }
}

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}