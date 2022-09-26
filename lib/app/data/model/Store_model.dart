//Delete this file

// import 'package:customer_app/app/data/model/wallet_model.dart';
// import 'package:hive/hive.dart';

// import 'address_model.dart';

// part 'user_model.g.dart';

// @HiveType(typeId: 0)
// class UserModel {
//   UserModel(
//       {this.id,
//       this.firstName,
//       this.wallet,
//       this.lastName,
//       this.mobile,
//       this.email,
//       this.addresses,
//       this.balance,
//       this.logo,
//       this.dateOfBirth,
//       this.maleOrFemale,
//       this.rank});

//   @HiveField(0)
//   String? id;

//   @HiveField(1)
//   String? firstName;

//   @HiveField(2)
//   String? lastName;

//   @HiveField(3)
//   String? mobile;

//   @HiveField(4)
//   String? email;

//   @HiveField(5)
//   List<AddressModel>? addresses;

//   @HiveField(6)
//   double? balance;

//   @HiveField(7)
//   String? logo;

//   @HiveField(8)
//   String? dateOfBirth;

//   @HiveField(9)
//   String? maleOrFemale;

//   @HiveField(10)
//   int? rank;

//   @HiveField(11)
//   List<Wallet>? wallet;

//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         id: json["_id"],
//         firstName: json["first_name"] ?? '',
//         lastName: json["last_name"] ?? '',
//         mobile: json["mobile"],
//         email: json["email"] ?? '',
//         addresses: json["addresses"] == null ? [] : List<AddressModel>.from(json["addresses"].map((x) => AddressModel.fromJson(x))),
//         balance: json["balance"] != null ? double.parse(json["balance"].toString()) : 0.0,
//         logo: json["logo"] ?? '',
//         dateOfBirth: json["date_of_birth"] ?? '',
//         maleOrFemale: json["male_or_female"] ?? '',
//         rank: json["rank"] ?? 0,
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id == null ? null : id,
//         "first_name": firstName,
//         "last_name": lastName,
//         "mobile": mobile == null ? null : mobile,
//         "email": email,
//         "addresses": addresses == null ? null : List<dynamic>.from(addresses!.map((x) => x)),
//         "balance": balance,
//         "logo": logo,
//         "date_of_birth": dateOfBirth,
//         "male_or_female": maleOrFemale,
//         "rank": rank
//       };
// }
