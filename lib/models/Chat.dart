import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String OwnerName;
  final String OwnerEmail;
  final String OwnerId;
  final String ChatID;
  final String OwnerProfileUrl;
  final String Content;
  List<String>? ChatImageContent;
  final Timestamp? PostedAt;
  int? ViewCount;
  int? CommentCount;
  final bool IsPrivate;

  Chat(
      {required this.Content,
      required this.ChatID,
      this.ChatImageContent,
      required this.OwnerId,
      required this.OwnerProfileUrl,
      required this.OwnerName,
      required this.OwnerEmail,
      
      this.CommentCount,
      this.PostedAt,
      this.ViewCount,
      required this.IsPrivate});

  Map<String, dynamic> toMap() {
    return {
      "OwnerId": OwnerId,
      "ChatImageContent": ChatImageContent ?? <String>[],
      "UserName": OwnerName,
      "Email": OwnerEmail,
      "OwnerProfileUrl": OwnerProfileUrl,
      "Content": Content,
      
      "PostedAt": PostedAt ?? FieldValue.serverTimestamp(),
      "ViewCount": ViewCount ?? 0,
      "CommentCount": CommentCount ?? 0,
      "IsPrivate": IsPrivate,
      "ChatID": ChatID
    };
  }

  Chat.fromMap(Map<String, dynamic> map)
      : OwnerName = map["UserName"],
        ChatImageContent = map["ChatImageContent"].cast<String>(),
        OwnerId = map["OwnerId"],
        OwnerEmail = map["Email"],
        OwnerProfileUrl = map["OwnerProfileUrl"],
        Content = map["Content"],
        
        PostedAt = map["PostedAt"],
        ViewCount = map["ViewCount"],
        CommentCount = map["CommentCount"],
        IsPrivate = map["IsPrivate"],
        ChatID = map["ChatID"];
}
