

class Report {
  final String Subject;
  

  String? ReportedChatID;
  String? ReportedCommentID;
  Report(
      {required this.Subject,
      
      this.ReportedChatID,
      this.ReportedCommentID});



       Map<String, dynamic> ToMap() {
    return {
      "Subject": Subject,
      
      "ReportedChatID": ReportedChatID ?? null,
      "ReportedCommentID": ReportedCommentID ?? null,
     
    };
  }
}
