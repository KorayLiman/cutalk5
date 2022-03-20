import 'package:ctlk2/locator.dart';
import 'package:ctlk2/models/Comment.dart';
import 'package:ctlk2/models/user.dart';
import 'package:ctlk2/models/Chat.dart';
import 'package:ctlk2/repository/chatrepository.dart';
import 'package:ctlk2/services/dbbase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ChatModel with ChangeNotifier implements DBBase {
  ChatRepository _chatRepository = locator<ChatRepository>();
  Chat? _chat;

  Chat? get chat => _chat;

/*CuTalkUser? _user;
  String? emailerrormessage;
  String? passworderrormessage;

  ViewState get viewstate => _viewState;
  CuTalkUser? get user => _user;
  set viewstate(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  } */

  // ChatModel(String ChatId) {
  //   currentChat(ChatId);
  // }

  @override
  Future<Chat> GetChat(String ChatID) async {
    _chat = await _chatRepository.GetChat(ChatID);
    return _chat!;
  }

  @override
  Future<CuTalkUser> ReadUser(String UserID) {
    // TODO: implement ReadUser
    throw UnimplementedError();
  }

  @override
  Future<bool> SaveChat(Chat chat) async {
    await _chatRepository.SaveChat(chat);
    return true;
  }

  @override
  Future<bool> SaveUser(
    CuTalkUser user,
  ) {
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
    return await _chatRepository.GetAllChats(IsUniversityChat);
  }

  @override
  Future<Chat> currentChat(String ChatID) async {
    return await _chatRepository.GetChat(ChatID);
  }

  Future<List<Comment>> GetAllComments(String ChatID) async {
    return await _chatRepository.GetAllComments(ChatID);
  }
}
