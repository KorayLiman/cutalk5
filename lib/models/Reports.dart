class Report {
  final String Subject;

  String? ReportedCommentContent;
  String? ReportedChatID;
  String? ReportedCommentID;
  Report({required this.Subject, this.ReportedChatID, this.ReportedCommentID,
  this.ReportedCommentContent});

  Map<String, dynamic> ToMap() {
    return {
      "Subject": Subject,
      "ReportedChatID": ReportedChatID ?? null,
      "ReportedCommentID": ReportedCommentID ?? null,
      "ReportedCommentContent":ReportedCommentContent?? null
    };
  }
}
