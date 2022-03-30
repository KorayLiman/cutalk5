class CuTalkUser {
  final String UserID;
  final bool IsFromUniversity;
  String Email;
  String? UserName;
  String? ProfileURL;
  CuTalkUser({
    required this.UserID,
    required this.Email,
    required this.IsFromUniversity,
    this.UserName,
    this.ProfileURL,
  });

  Map<String, dynamic> ToMap() {
    return {
      "UserID": UserID,
      "IsFromUniversity":IsFromUniversity,
      "Email": Email,
      "UserName": UserName ?? "Apple User",
      "ProfileURL": ProfileURL ??
          "https://scontent.fist4-1.fna.fbcdn.net/v/t1.6435-9/33248868_2139061783009197_3860205585035165696_n.png?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=ESP2-TU7d68AX-7r8Lg&_nc_ht=scontent.fist4-1.fna&oh=00_AT_kNqR2wFyPzFibQCpC57MtmhAdlwqFfI-x6RnpHVqGlA&oe=626945C9"
    };
  }

  CuTalkUser.FromMap(Map<String, dynamic> map)
      : UserID = map["UserID"],
      IsFromUniversity = map["IsFromUniversity"],
        Email = map["Email"],
        UserName = map["UserName"],
        ProfileURL = map["ProfileURL"];
}
