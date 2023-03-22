class User {
  String? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? image;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? cmFirebaseToken;
  String? loginMedium;
  String? socialId;
  String? zoneId;
  String? refCode;
  String? userinfo;
  int? isPhoneVerified;
  int? walletBalance;
  int? loyaltyPoint;
  int? status;
  int? orderCount;
  int? memberSinceDays;

  User(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.email,
        this.image,
        this.isPhoneVerified,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.cmFirebaseToken,
        this.status,
        this.orderCount,
        this.loginMedium,
        this.socialId,
        this.zoneId,
        this.walletBalance,
        this.loyaltyPoint,
        this.refCode,
        this.userinfo,
        this.memberSinceDays});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    isPhoneVerified = json['is_phone_verified'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cmFirebaseToken = json['cm_firebase_token'];
    status = json['status'];
    orderCount = json['order_count'];
    loginMedium = json['login_medium'];
    socialId = json['social_id'];
    zoneId = json['zone_id'].toString();
    walletBalance = json['wallet_balance'];
    loyaltyPoint = json['loyalty_point'];
    refCode = json['ref_code'];
    userinfo = json['userinfo'];
    memberSinceDays = json['member_since_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.image;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['cm_firebase_token'] = this.cmFirebaseToken;
    data['status'] = this.status;
    data['order_count'] = this.orderCount;
    data['login_medium'] = this.loginMedium;
    data['social_id'] = this.socialId;
    data['zone_id'] = this.zoneId;
    data['wallet_balance'] = this.walletBalance;
    data['loyalty_point'] = this.loyaltyPoint;
    data['ref_code'] = this.refCode;
    data['userinfo'] = this.userinfo;
    data['member_since_days'] = this.memberSinceDays;
    return data;
  }
}
