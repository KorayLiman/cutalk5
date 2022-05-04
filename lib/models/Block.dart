class Block {
  String? ReportedCommentContent;
  String? ReportedChatID;
  String? ReportedCommentID;
  String ReportingUserID;
  String ReportedUserID;
  Block(
      {this.ReportedChatID,
      this.ReportedCommentID,
      required this.ReportedUserID,
      required this.ReportingUserID,
      this.ReportedCommentContent});

  Map<String, dynamic> ToMap() {
    return {
      "ReportedChatID": ReportedChatID ?? null,
      "ReportingUserID": ReportingUserID,
      "ReportedUserID":ReportedUserID,
      "ReportedCommentID": ReportedCommentID ?? null,
      "ReportedCommentContent": ReportedCommentContent ?? null
    };
  }
}
