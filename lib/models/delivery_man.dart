class DeliveryMan {
  String? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? identityNumber;
  String? identityType;
  String? identityImage;
  String? image;
  Null? fcmToken;
  int? zoneId;
  String? createdAt;
  String? updatedAt;
  String? status;
  int? active;
  int? earning;
  int? currentOrders;
  String? type;
  Null? restaurantId;
  String? applicationStatus;
  int? orderCount;
  int? assignedOrderCount;
  int? avgRating;
  int? ratingCount;
  int? todaysOrderCount;
  int? thisWeekOrderCount;
  int? memberSinceDays;
  int? cashInHands;
  int? balance;
  int? todaysEarning;
  int? thisWeekEarning;
  int? thisMonthEarning;
  Null? userinfo;
  String? currentLat;
  String? currentLng;

  DeliveryMan(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.email,
        this.identityNumber,
        this.identityType,
        this.identityImage,
        this.image,
        this.fcmToken,
        this.zoneId,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.active,
        this.earning,
        this.currentOrders,
        this.type,
        this.restaurantId,
        this.applicationStatus,
        this.orderCount,
        this.assignedOrderCount,
        this.avgRating,
        this.ratingCount,
        this.todaysOrderCount,
        this.thisWeekOrderCount,
        this.memberSinceDays,
        this.cashInHands,
        this.balance,
        this.todaysEarning,
        this.thisWeekEarning,
        this.thisMonthEarning,
        this.currentLat,
      this.currentLng,
        this.userinfo});

  DeliveryMan.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    identityNumber = json['identity_number'];
    identityType = json['identity_type'];
    identityImage = json['identity_image'];
    image = json['image'];
    fcmToken = json['fcm_token'];
    zoneId = json['zone_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'].toString();
    active = json['active'];
    earning = json['earning'];
    currentOrders = json['current_orders'];
    type = json['type'];
    restaurantId = json['restaurant_id'];
    applicationStatus = json['application_status'];
    orderCount = json['order_count'];
    assignedOrderCount = json['assigned_order_count'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
    todaysOrderCount = json['todays_order_count'];
    thisWeekOrderCount = json['this_week_order_count'];
    memberSinceDays = json['member_since_days'];
    cashInHands = json['cash_in_hands'];
    balance = json['balance'];
    todaysEarning = json['todays_earning'];
    thisWeekEarning = json['this_week_earning'];
    thisMonthEarning = json['this_month_earning'];
    userinfo = json['userinfo'];
    currentLat = json['current_lat'];
    currentLng = json['current_lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['identity_number'] = this.identityNumber;
    data['identity_type'] = this.identityType;
    data['identity_image'] = this.identityImage;
    data['image'] = this.image;
    data['fcm_token'] = this.fcmToken;
    data['zone_id'] = this.zoneId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['active'] = this.active;
    data['earning'] = this.earning;
    data['current_orders'] = this.currentOrders;
    data['type'] = this.type;
    data['restaurant_id'] = this.restaurantId;
    data['application_status'] = this.applicationStatus;
    data['order_count'] = this.orderCount;
    data['assigned_order_count'] = this.assignedOrderCount;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['todays_order_count'] = this.todaysOrderCount;
    data['this_week_order_count'] = this.thisWeekOrderCount;
    data['member_since_days'] = this.memberSinceDays;
    data['cash_in_hands'] = this.cashInHands;
    data['balance'] = this.balance;
    data['todays_earning'] = this.todaysEarning;
    data['this_week_earning'] = this.thisWeekEarning;
    data['this_month_earning'] = this.thisMonthEarning;
    data['userinfo'] = this.userinfo;

    data['current_lat'] = this.currentLat;
    data['current_lng'] = this.currentLng;
    return data;
  }
}