import 'package:hive/hive.dart';

part 'address_model.g.dart';

@HiveType(typeId: 1)
class AddressModel {
  AddressModel({this.address, this.apartment, this.house, this.location, this.status, this.title, this.directionReach, this.id, this.distance});

  @HiveField(0)
  String? id;

  @HiveField(1)
  String? address;

  @HiveField(2)
  String? title;

  @HiveField(3)
  String? house;

  @HiveField(4)
  String? apartment;

  @HiveField(5)
  bool? status;

  @HiveField(6)
  CoordinateModel? location;

  @HiveField(7)
  String? directionReach;

  @HiveField(8)
  String? distance;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["_id"],
        address: json["address"] == null ? '' : json["address"],
        directionReach: json["direction_to_reach"] == null ? '' : json["direction_to_reach"],
        distance: json["distance"] == null ? '' : json["distance"],
        status: json["status"] == null ? '' : json["status"],
        title: json["title"] == null ? '' : json["title"],
        apartment: json['apartment'],
        house: json['house'],
        location: json["location"] == null ? CoordinateModel() : CoordinateModel.fromJson(json["location"]),
      );
}

@HiveType(typeId: 3)
class CoordinateModel {
  CoordinateModel({
    this.lat,
    this.lng,
  });

  @HiveField(0)
  double? lat;

  @HiveField(1)
  double? lng;

  factory CoordinateModel.fromJson(Map<String, dynamic> json) => CoordinateModel(
        lat: json["lat"] == null ? 0.0 : json["lat"].toDouble(),
        lng: json["lng"] == null ? 0.0 : json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}
