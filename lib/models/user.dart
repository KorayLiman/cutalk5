class CuTalkUser {
  final String UserID;
  final bool IsFromUniversity;
  String Email;
  String? UserName;
  bool IsBlocked;
  String? ProfileURL;
  CuTalkUser({
    required this.UserID,
    required this.Email,
    required this.IsBlocked,
    required this.IsFromUniversity,
    this.UserName,
    this.ProfileURL,
  });

  Map<String, dynamic> ToMap() {
    return {
      "UserID": UserID,
      "IsFromUniversity": IsFromUniversity,
      "Email": Email,
      "IsBlocked": IsBlocked,
      "UserName": UserName ?? "Apple User",
      "ProfileURL": ProfileURL ??
          "https://static.wixstatic.com/media/26e925_dbd5b81fa3614bfc82f5fdea0566f7de~mv2.png/v1/fill/w_45,h_45,al_c,lg_1,q_90/26e925_dbd5b81fa3614bfc82f5fdea0566f7de~mv2.webp"
    };
  }

  CuTalkUser.FromMap(Map<String, dynamic> map)
      : UserID = map["UserID"],
        IsFromUniversity = map["IsFromUniversity"],
        Email = map["Email"],
        IsBlocked = map["IsBlocked"],
        UserName = map["UserName"],
        ProfileURL = map["ProfileURL"];
}
