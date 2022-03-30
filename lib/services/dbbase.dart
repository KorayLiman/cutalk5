import 'package:ctlk2/models/Chat.dart';
import 'package:ctlk2/models/user.dart';

abstract class DBBase {
  Future<bool> SaveUser(
    CuTalkUser user,
  );
  Future<CuTalkUser> ReadUser(String UserID);
  Future<bool> UpdateUserName(String UserID, String NewUserName);
  Future<bool> UpdateProfilePhoto(String UserID, String NewProfilePhotoURL);
  Future<bool> SaveChat(Chat chat);
  Future<Chat> GetChat(String ChatID);
  Future<void> DeleteAccount();
  Future<List<Chat>> GetAllChats(bool IsUniversityChat);
}
