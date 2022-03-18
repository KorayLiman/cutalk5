import 'package:ctlk2/models/user.dart';

abstract class DBBase {
  Future<bool> SaveUser(CuTalkUser user);
  Future<CuTalkUser> ReadUser(String UserID);
  Future<bool> UpdateUserName(String UserID, String NewUserName);
  Future<bool> UpdateProfilePhoto(String UserID, String NewProfilePhotoURL);
}
