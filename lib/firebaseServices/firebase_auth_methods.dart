import 'package:demo/ui/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../ui/authentication_screens/login_screen.dart';
import '../utils/showSnackBar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // Email Sign up
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Removed email verification
      showSnackBar(context, 'Sign up successful!');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AppMainScreen()),);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message ?? 'An error occurred');
    }
  }

  // Email Login
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Removed email verification check
      showSnackBar(context, 'Login successful!');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AppMainScreen()),);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message ?? 'An error occurred');
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      // Navigate to login screen after successful logout
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
            (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message ?? 'An error occurred during logout');
    }
  }
}