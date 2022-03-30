import 'package:ctlk2/models/user.dart';

abstract class AuthBase {
  Future<CuTalkUser?> currentUser();
  Future<CuTalkUser?> signinwithGoogle();
  Future<CuTalkUser?> signinwithApple();
  Future<bool> signOut();
  Future<void> DeleteAccount();
  Future<CuTalkUser?> signinwithEmailAndPassword(String email, String password);
  Future<CuTalkUser?> createUserWithEmailandPassword(
      String name, String email, String pw);
}
