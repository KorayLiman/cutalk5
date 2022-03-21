import 'dart:io';

import 'package:ctlk2/locator.dart';
import 'package:ctlk2/models/user.dart';
import 'package:ctlk2/services/authbase.dart';
import 'package:ctlk2/services/firebase_storage_service.dart';
import 'package:ctlk2/services/firebaseauthservice.dart';
import 'package:ctlk2/services/firestore_db_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository implements AuthBase {
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();
  final FireStoreDBService _fireStoreDBService = locator<FireStoreDBService>();
  final FirebaseStorageService _fireBaseStorageService =
      locator<FirebaseStorageService>();

  List<CuTalkUser> allUserList = [];

  @override
  Future<CuTalkUser?> createUserWithEmailandPassword(
      String name, String email, String pw) async {
    CuTalkUser? user = await _firebaseAuthService
        .createUserWithEmailandPassword(name, email, pw);
    user!.UserName = name;
    bool result = await _fireStoreDBService.SaveUser(user);
    if (result) {
      return await _fireStoreDBService.ReadUser(user.UserID);
    } else {
      return null;
    }
  }

  Future<bool> updateUserName(String userID, String yeniUserName) async {
    return await _fireStoreDBService.UpdateUserName(userID, yeniUserName);
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

  Future<String> uploadFile(String userId, String fileType, File? image) async {
    String ProfilePhotoUrl =
        await _fireBaseStorageService.uploadFile(userId, fileType, image!);
    await _fireStoreDBService.UpdateProfilePhoto(userId, ProfilePhotoUrl);
    return ProfilePhotoUrl;
  }

  Future<String> uploadChatFile(
      String userID, String s, File i, String ChatID) async {
    String url = await _fireBaseStorageService.uploadChatFile(userID, s, i);
    await _fireStoreDBService.updateChatPhotos(userID, url, ChatID);
    return url;
  }
}
