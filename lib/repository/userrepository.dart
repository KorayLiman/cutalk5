import 'package:ctlk2/locator.dart';
import 'package:ctlk2/models/user.dart';
import 'package:ctlk2/services/authbase.dart';
import 'package:ctlk2/services/firebase_storage_service.dart';
import 'package:ctlk2/services/firebaseauthservice.dart';
import 'package:ctlk2/services/firestore_db_service.dart';

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FireStoreDBService _fireStoreDBService = locator<FireStoreDBService>();
  FirebaseStorageService _fireBaseStorageService =
      locator<FirebaseStorageService>();

  List<CuTalkUser> allUserList = [];

  @override
  Future<CuTalkUser?> createUserWithEmailandPassword(
      String email, String pw) async {
    CuTalkUser? user =
        await _firebaseAuthService.createUserWithEmailandPassword(email, pw);
    bool result = await _fireStoreDBService.SaveUser(user!);
    if (result) {
      return await _fireStoreDBService.ReadUser(user.UserID);
    } else {
      return null;
    }
  }

  @override
  Future<CuTalkUser?> currentUser() async {
    CuTalkUser? user = await _firebaseAuthService.currentUser();
    if (user != null) {
      return await _fireStoreDBService.ReadUser(user.UserID);
    } else {
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    return await _firebaseAuthService.signOut();
  }

  @override
  Future<CuTalkUser?> signinwithEmailAndPassword(
      String email, String password) async {
    CuTalkUser? user =
        await _firebaseAuthService.signinwithEmailAndPassword(email, password);
    return await _fireStoreDBService.ReadUser(user!.UserID);
  }

  @override
  Future<CuTalkUser?> signinwithGoogle() async {
    CuTalkUser? user = await _firebaseAuthService.signinwithGoogle();
    bool result = await _fireStoreDBService.SaveUser(user!);
    if (result) {
      return await _fireStoreDBService.ReadUser(user.UserID);
    } else {
      return null;
    }
  }
}
