import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctlk2/models/user.dart';
import 'package:ctlk2/services/authbase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<CuTalkUser?> createUserWithEmailandPassword(
      String name, String email, String pw) async {
    UserCredential credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pw);
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

  @override
  Future<CuTalkUser?> signinwithGoogle() async {
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
  }

  Future<CuTalkUser?> _userFromFirebase(User? user) async {
    if (user == null) {
      return null;
    } else {
      
      return CuTalkUser(
          UserID: user.uid, Email: user.email ?? "",);
    }
  }
}
