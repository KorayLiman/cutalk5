import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String OwnerName;
  final String OwnerEmail;
  final String OwnerId;
  final String ChatID;
  final String OwnerProfileUrl;
  final String Content;
  List<String>? ChatImageContent;
  int? ImageCount;
  final Timestamp? PostedAt;
  int? ViewCount;
  int? CommentCount;
  final bool IsPrivate;
  int? LikeCount;
  Map? Likes;

  Chat(
      {required this.Content,
      required this.ChatID,
      this.ChatImageContent,
      required this.OwnerId,
      this.LikeCount,
      this.ImageCount,
      required this.OwnerProfileUrl,
      required this.OwnerName,
      required this.OwnerEmail,
      this.CommentCount,
      this.Likes,
      this.PostedAt,
      this.ViewCount,
      required this.IsPrivate});

  Map<String, dynamic> toMap() {
    return {
      "OwnerId": OwnerId,
      "ChatImageContent": ChatImageContent ?? <String>[],
      "UserName": OwnerName,
      "Email": OwnerEmail,
      "Likes": Likes?? <String,bool>{},
      "OwnerProfileUrl": OwnerProfileUrl,
      "ImageCount": ImageCount ?? 0,
      "Content": Content,
      "PostedAt": PostedAt ?? FieldValue.serverTimestamp(),
      "ViewCount": ViewCount ?? 0,
      "CommentCount": CommentCount ?? 0,
      "LikeCount": LikeCount ?? 0,
      "IsPrivate": IsPrivate,
      "ChatID": ChatID
    };
  }

  Chat.fromMap(Map<String, dynamic> map)
      : OwnerName = map["UserName"],
        ChatImageContent = map["ChatImageContent"].cast<String>(),
        OwnerId = map["OwnerId"],
        Likes = map["Likes"],
        OwnerEmail = map["Email"],
        ImageCount = map["ImageCount"],
        OwnerProfileUrl = map["OwnerProfileUrl"],
        Content = map["Content"],
        PostedAt = map["PostedAt"],
        ViewCount = map["ViewCount"],
        CommentCount = map["CommentCount"],
        LikeCount = map["LikeCount"],
        IsPrivate = map["IsPrivate"],
        ChatID = map["ChatID"];
}
