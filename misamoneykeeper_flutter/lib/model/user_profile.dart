class UserProfile {
  int? userId;
  dynamic userDetailsId;
  String? email;
  String? mobile;
  String? uName;
  String? uImage;
  dynamic uGender;
  String? uBirthday;
  String? uAddress;
  String? uJob;

  UserProfile(
      {this.userId,
      this.userDetailsId,
      this.email,
      this.mobile,
      this.uName,
      this.uImage,
      this.uGender,
      this.uBirthday,
      this.uAddress,
      this.uJob});

  UserProfile.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userDetailsId = json['user_details_id'];
    email = json['email'];
    mobile = json['mobile'];
    uName = json['u_name'];
    uImage = json['u_image'];
    uGender = json['u_gender'];
    uBirthday = json['u_birthday'];
    uAddress = json['u_address'];
    uJob = json['u_job'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_details_id'] = userDetailsId;
    data['email'] = email;
    data['mobile'] = mobile;
    data['u_name'] = uName;
    data['u_image'] = uImage;
    data['u_gender'] = uGender;
    data['u_birthday'] = uBirthday;
    data['u_address'] = uAddress;
    data['u_job'] = uJob;
    return data;
  }
}
