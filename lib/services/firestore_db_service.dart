import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctlk2/models/user.dart';
import 'package:ctlk2/services/dbbase.dart';

class FireStoreDBService implements DBBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<CuTalkUser> ReadUser(String UserID) async {
    DocumentSnapshot snapshot =
        await _firestore.collection("users").doc(UserID).get();
    Map<String, dynamic> _readUserMap = snapshot.data() as Map<String, dynamic>;
    CuTalkUser
  }

  @override
  Future<bool> SaveUser(CuTalkUser user) async {
    await _firestore.collection("users").doc(user.UserID).set(user.ToMap());

    DocumentSnapshot snapshot =
        await _firestore.collection("users").doc(user.UserID).get();
    Map<String, dynamic> ReadUserInformation =
        snapshot.data() as Map<String, dynamic>;
    CuTalkUser ReadUserObject = CuTalkUser.FromMap(ReadUserInformation);
    return true;
  }

  @override
  Future<bool> UpdateProfilePhoto(String UserID, String NewProfilePhotoURL) {}

  @override
  Future<bool> UpdateUserName(String UserID, String NewUserName) {}
}
