import 'package:ctlk2/locator.dart';
import 'package:ctlk2/models/Comment.dart';
import 'package:ctlk2/models/user.dart';
import 'package:ctlk2/models/Chat.dart';
import 'package:ctlk2/services/dbbase.dart';
import 'package:ctlk2/services/firestore_db_service.dart';


class ChatRepository implements DBBase {
  final FireStoreDBService _fireStoreDBService = locator<FireStoreDBService>();

  @override
  Future<Chat> GetChat(String ChatID) async {
    Chat chat = await _fireStoreDBService.GetChat(ChatID);
    return chat;
  }

  @override
  Future<CuTalkUser> ReadUser(String UserID) {
    // TODO: implement ReadUser
    throw UnimplementedError();
  }

  @override
  Future<bool> SaveChat(Chat chat) async {
    return await _fireStoreDBService.SaveChat(chat);
  }

  @override
  Future<bool> SaveUser(CuTalkUser user) {
    // TODO: implement SaveUser
    throw UnimplementedError();
  }

  @override
  Future<bool> UpdateProfilePhoto(String UserID, String NewProfilePhotoURL) {
    // TODO: implement UpdateProfilePhoto
    throw UnimplementedError();
  }

  @override
  Future<bool> UpdateUserName(String UserID, String NewUserName) {
    // TODO: implement UpdateUserName
    throw UnimplementedError();
  }

  @override
  Future<List<Chat>> GetAllChats(bool IsUniversityChat) async {
    List<Chat> ChatList =
        await _fireStoreDBService.GetAllChats(IsUniversityChat);
    return ChatList;
  }

  Future<List<Comment>> GetAllComments(String ChatID) async {
    return await _fireStoreDBService.GetAllComments(ChatID);
  }

  @override
  Future<void> DeleteAccount() async{
    
  }
}
