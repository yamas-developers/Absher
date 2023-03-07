class QueryParams {
  QueryParams({this.searchedText, this.rating, this.showTopRated});

  String? searchedText;
  double? rating;
  bool? showTopRated;
}

class ExpressAddress {
  ExpressAddress(
      {this.address,
      this.name,
      this.addressDetails,
      this.city,
      this.phone,
      this.lat,
      this.lng});

  String? name;
  String? address;
  String? addressDetails;
  String? city;
  String? phone;
  double? lat;
  double? lng;
}
