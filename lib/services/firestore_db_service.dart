import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctlk2/models/Chat.dart';
import 'package:ctlk2/models/Comment.dart';
import 'package:ctlk2/models/user.dart';
import 'package:ctlk2/services/dbbase.dart';

class FireStoreDBService implements DBBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<CuTalkUser> ReadUser(String UserID) async {
    DocumentSnapshot snapshot =
        await _firestore.collection("users").doc(UserID).get();
    Map<String, dynamic> _readUserMap = snapshot.data() as Map<String, dynamic>;
    CuTalkUser user = CuTalkUser.FromMap(_readUserMap);
    return user;
  }

  @override
  Future<bool> SaveUser(CuTalkUser Cuuser) async {
    
    await _firestore.collection("users").doc(Cuuser.UserID).set(Cuuser.ToMap());
    await _firestore
        .collection("users")
        .doc(Cuuser.UserID)
        .set({"UserName": Cuuser.UserName}, SetOptions(merge: true));

    DocumentSnapshot snapshot =
        await _firestore.collection("users").doc(Cuuser.UserID).get();
    Map<String, dynamic> ReadUserInformation =
        snapshot.data() as Map<String, dynamic>;
    CuTalkUser ReadUserObject = CuTalkUser.FromMap(ReadUserInformation);
    return true;
  }

  @override
  Future<bool> UpdateProfilePhoto(
      String UserID, String NewProfilePhotoURL) async {
    await _firestore
        .collection("users")
        .doc(UserID)
        .update({"ProfileURL": NewProfilePhotoURL});
    return true;
  }

  updateChatPhotos(String userID, String url, String ChatID) async {
    await _firestore.collection("chats").doc(ChatID).update({
      "ChatImageContent": FieldValue.arrayUnion([url])
    });
  }

  @override
  Future<bool> UpdateUserName(String UserID, String NewUserName) async {
    // QuerySnapshot users = await _firestore
    //     .collection("users")
    //     .where("UserName", isEqualTo: NewUserName)
    //     .get();
    try {
      await _firestore
          .collection("users")
          .doc(UserID)
          .update({"UserName": NewUserName});
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  @override
  Future<Chat> GetChat(String ChatID) async {
    //  DocumentSnapshot snapshot =
    //       await _firestore.collection("users").doc(UserID).get();
    //   Map<String, dynamic> _readUserMap = snapshot.data() as Map<String, dynamic>;
    //   CuTalkUser user = CuTalkUser.FromMap(_readUserMap);
    //   return user;

    DocumentSnapshot snapshot =
        await _firestore.collection("chats").doc(ChatID).get();
    Map<String, dynamic> _ReadChatMap = snapshot.data() as Map<String, dynamic>;
    Chat chat = Chat.fromMap(_ReadChatMap);
    return chat;
  }

  @override
  Future<bool> SaveChat(Chat chat) async {
    await _firestore.collection("chats").doc(chat.ChatID).set(chat.toMap());
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("chats").doc(chat.ChatID).get();
    Map<String, dynamic> ReadChatInformation =
        documentSnapshot.data() as Map<String, dynamic>;
    Chat ChatObject = Chat.fromMap(ReadChatInformation);
    return true;
  }

  @override
  Future<List<Chat>> GetAllChats(bool IsUniversityChat) async {
    List<Chat> ChatList = [];
    QuerySnapshot snapshot = await _firestore
        .collection("chats")
        .where("IsPrivate", isEqualTo: IsUniversityChat)
        .orderBy("PostedAt", descending: true)
        .get();
    for (var chat in snapshot.docs) {
      Chat ch = Chat.fromMap(chat.data() as Map<String, dynamic>);
      ChatList.add(ch);
    }
    return ChatList;
  }

  Future<List<Comment>> GetAllComments(String chatID) async {
    List<Comment> list = [];
    QuerySnapshot docs = await _firestore
        .collection("comments")
        .where("BelongingChatID", isEqualTo: chatID)
        .orderBy("SentAt", descending: true)
        .get();
    for (var doc in docs.docs) {
      Comment comment = Comment.fromMap(doc.data() as Map<String, dynamic>);
      list.add(comment);
    }

    return list;
  }
}
