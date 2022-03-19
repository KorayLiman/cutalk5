import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctlk2/models/user.dart';

class Chat {
  final String OwnerID;
  final String OwnerProfileUrl;
  final String Content;
  List<String>? Comments;
  final Timestamp? PostedAt;
  int? ViewCount;
  int? CommentCount;
  final bool IsPrivate;

  Chat(
      {required this.Content,
      required this.OwnerProfileUrl,
      required this.OwnerID,
      this.Comments,
      this.CommentCount,
      this.PostedAt,
      this.ViewCount,
      required this.IsPrivate});

  Map<String, dynamic> toMap() {
    return {
      "OwnerID": OwnerID,
      "OwnerProfileUrl": OwnerProfileUrl,
      "Content": Content,
      "Comments": Comments ?? <String>[],
      "PostedAt": PostedAt ?? FieldValue.serverTimestamp(),
      "ViewCount": ViewCount ?? 0,
      "CommentCount": CommentCount ?? 0,
      "IsPrivate": IsPrivate
    };
  }

  Chat.fromMap(Map<String, dynamic> map)
      : OwnerID = map["OwnerID"],
        OwnerProfileUrl = map["OwnerProfileUrl"],
        Content = map["Content"],
        Comments = map["Comments"],
        PostedAt = map["PostedAt"],
        ViewCount = map["ViewCount"],
        CommentCount = map["CommentCount"],
        IsPrivate = map["IsPrivate"];
}
