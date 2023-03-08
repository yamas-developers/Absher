class DeliveryAddress {
  String? contactPersonName;
  String? contactPersonNumber;
  String? addressType;
  String? address;
  String? floor;
  String? road;
  String? house;
  String? longitude;
  String? latitude;

  DeliveryAddress(
      {this.contactPersonName,
        this.contactPersonNumber,
        this.addressType,
        this.address,
        this.floor,
        this.road,
        this.house,
        this.longitude,
        this.latitude});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    addressType = json['address_type'];
    address = json['address'];
    floor = json['floor'];
    road = json['road'];
    house = json['house'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['contact_person_name'] = this.contactPersonName;
    data['contact_person_number'] = this.contactPersonNumber;
    data['address_type'] = this.addressType;
    data['address'] = this.address;
    data['floor'] = this.floor;
    data['road'] = this.road;
    data['house'] = this.house;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}