class AddressModel {
  AddressModel(
      {this.address,
      this.apartment,
      this.house,
      this.location,
      this.status,
      this.title,
      this.id});

  String? id;
  String? address;
  String? title;
  String? house;
  String? apartment;
  bool? status;
  CoordinateModel? location;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["_id"],
        address: json["address"] == null ? '' : json["address"],
        status: json["status"] == null ? '' : json["status"],
        title: json["title"] == null ? '' : json["title"],
        apartment: json['apartment'],
        house: json['house'],
        location: json["location"] == null
            ? CoordinateModel()
            : CoordinateModel.fromJson(json["location"]),
      );
}

class CoordinateModel {
  CoordinateModel({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory CoordinateModel.fromJson(Map<String, dynamic> json) =>
      CoordinateModel(
        lat: json["lat"] == null ? 0.0 : json["lat"].toDouble(),
        lng: json["lng"] == null ? 0.0 : json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}
