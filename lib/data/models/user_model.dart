import 'package:customer_app/data/models/address_model.dart';

class UserModel {
  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.addresses,
    this.balance,
    this.logo,
    this.dateOfBirth,
    this.maleOrFemale,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  List<AddressModel>? addresses;
  double? balance;
  String? logo;
  String? dateOfBirth;
  String? maleOrFemale;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        mobile: json["mobile"],
        email: json["email"] ?? '',
        addresses: json["addresses"] == null
            ? []
            : List<AddressModel>.from(
                json["addresses"].map((x) => AddressModel.fromJson(x))),
        balance: json["balance"] != null
            ? double.parse(json["balance"].toString())
            : 0.0,
        logo: json["logo"] ?? '',
        dateOfBirth: json["date_of_birth"] ?? '',
        maleOrFemale: json["male_or_female"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile == null ? null : mobile,
        "email": email,
        "addresses": addresses == null
            ? null
            : List<dynamic>.from(addresses!.map((x) => x)),
        "balance": balance,
        "logo": logo,
        "date_of_birth": dateOfBirth,
        "male_or_female": maleOrFemale,
      };
}
