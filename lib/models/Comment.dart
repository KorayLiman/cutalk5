import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctlk2/models/user.dart';

class Comment {
  final String OwnerID;
  final String BelongingChatID;
  final String Content;
  final Timestamp? SentAt;

  Comment(
      {required this.OwnerID,
      required this.BelongingChatID,
      required this.Content,
      this.SentAt});

  Map<String, dynamic> toMap() {
    return {
      "OwnerID": OwnerID,
      "SentAt": SentAt ?? FieldValue.serverTimestamp(),
      "BelongingChatID": BelongingChatID,
      "Content": Content,
    };
  }

  Comment.fromMap(Map<String, dynamic> map)
      : OwnerID = map["OwnerID"],
        SentAt = map["SentAt"],
        BelongingChatID = map["BelongingChatID"],
        Content = map["Content"];
}
