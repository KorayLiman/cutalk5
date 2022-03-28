import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctlk2/models/user.dart';
import 'package:ctlk2/services/authbase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<CuTalkUser?> createUserWithEmailandPassword(
      String name, String email, String pw) async {
    UserCredential credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pw);

    await credential.user!.sendEmailVerification();

    return await _userFromFirebase(credential.user);
  }

  @override
  Future<CuTalkUser?> currentUser() async {
    try {
      User? _user = await _firebaseAuth.currentUser;
      return _userFromFirebase(_user);
    } catch (error) {
      print("Current User Error: " + error.toString());
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (error) {
      print("SignOut Error: " + error.toString());
      return false;
    }
  }

  @override
  Future<CuTalkUser?> signinwithEmailAndPassword(
      String email, String password) async {
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return await _userFromFirebase(credential.user);
  }

  Future<CuTalkUser?> _userFromFirebase(User? user) async {
    if (user == null) {
      return null;
    } else {
      bool IsFromUniversity = false;
      if (user.email!.contains("@cumhuriyet.edu.tr")) IsFromUniversity = true;

      String? url;
      DocumentSnapshot? fbuser = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      if (fbuser.exists)
        url = fbuser["ProfileURL"].toString();
      else
        url = null;
      return CuTalkUser(
          UserID: user.uid,
          Email: user.email!,
          ProfileURL: url,
          UserName: user.displayName ?? "İsim alınamadı",
          IsFromUniversity: IsFromUniversity ? true : false);
    }
  }

  @override
  Future<CuTalkUser?> signinwithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential crd =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return await _userFromFirebase(crd.user);
    } on PlatformException catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<CuTalkUser?> signinwithApple() async {
    try {
      if (Platform.isIOS) {
        final acredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        print(acredential);

        final oAuthProvider = OAuthProvider("apple.com");
        final credential = oAuthProvider.credential(
            idToken: acredential.identityToken,
            accessToken: acredential.authorizationCode);
        UserCredential crd =
            await FirebaseAuth.instance.signInWithCredential(credential);
        return await _userFromFirebase(crd.user);
      }
    } catch (error) {
      print(error);
    }
  }
}
