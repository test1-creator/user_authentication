
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_authentication/firebase/firebase_services.dart';

class AuthProvider extends ChangeNotifier{
  bool loggedIn = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream get authState {
    return FirebaseAuth.instance.authStateChanges();
  }

  bool get isLoggedIn => loggedIn;

  set isLoggedIn(bool value) {
    loggedIn = value;
    notifyListeners();
  }

  Future<bool> signUp(context, _email, _password, _name, _mobile) async {
    String _errorMessage = "";
    try {
      UserCredential userCredentials = await auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      await FirebaseServices.addUser(userCredentials.user!.uid, _name, _mobile, _email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _errorMessage =
        'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        _errorMessage =
        'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        _errorMessage =
        'The entered email is invalid.';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
          content: Text(_errorMessage,
            textAlign: TextAlign.center,
          )));
    } catch (e) {
      _errorMessage =
      'Something went wrong. Try Again later';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
          content: Text(
            _errorMessage,
            textAlign: TextAlign.center,
          )));
    }
    return false;
  }

  Future<bool> login(context, _email, _password) async {
    String _errorMessage = "";
    try {
      await FirebaseAuth
          .instance
          .signInWithEmailAndPassword(
          email: _email, password: _password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _errorMessage =
        'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        _errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        _errorMessage =
        'The entered email is invalid.';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
          content: Text(
            _errorMessage,
            textAlign: TextAlign.center,
          )));
    } catch (e) {
      _errorMessage =
      'Something went wrong. Try Again later';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
          content: Text(
            _errorMessage,
            textAlign: TextAlign.center,
          )));
    }
    return false;
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    loggedIn = false;
    notifyListeners();
  }
}