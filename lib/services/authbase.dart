import 'package:ctlk2/models/user.dart';

abstract class AuthBase {
  Future<CuTalkUser?> currentUser();
  Future<CuTalkUser?> signinwithGoogle();
  Future<bool> signOut();
  Future<CuTalkUser?> signinwithEmailAndPassword(String email, String password);
  Future<CuTalkUser?> createUserWithEmailandPassword(String email, String pw);
}
