class CuTalkUser {
  final String UserID;
  String Email;
  //String UserName;
  String? ProfileURL;
  CuTalkUser({
    required this.UserID,
    required this.Email,
    required this.UserName,
    this.ProfileURL,
  });

  Map<String, dynamic> ToMap() {
    return {
      "UserID": UserID,
      "Email": Email,
      "UserName": UserName,
      "ProfileURL": ProfileURL ??
          "https://yt3.ggpht.com/yti/APfAmoGqgJ51RGDUDAXP0Ig6k6QzVR78JteXyPyP-g=s88-c-k-c0x00ffffff-no-rj-mo"
    };
  }

  CuTalkUser.FromMap(Map<String, dynamic> map) : UserID = map["UserID"],
  Email = map["Email"],
  UserName = map["UserName"],
  ProfileURL = map["ProfileURL"]
  ;
}
