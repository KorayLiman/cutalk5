import 'package:cloud_firestore/cloud_firestore.dart';


class Comment {
  final String OwnerID;
  final String BelongingChatID;
  final String Content;
  final String CommentID;
  final Timestamp? SentAt;

  Comment(
      {required this.OwnerID,
      required this.CommentID,
      required this.BelongingChatID,
      required this.Content,
      this.SentAt});

  Map<String, dynamic> toMap() {
    return {
      "OwnerID": OwnerID,
      "SentAt": SentAt ?? FieldValue.serverTimestamp(),
      "BelongingChatID": BelongingChatID,
      "CommentID":CommentID,
      "Content": Content,
    };
  }

  Comment.fromMap(Map<String, dynamic> map)
      : OwnerID = map["OwnerID"],
        SentAt = map["SentAt"],
        CommentID = map["CommentID"],
        BelongingChatID = map["BelongingChatID"],
        Content = map["Content"];
}
