// class CustomerWallet {
//   Data? data;

//   CustomerWallet({this.data});

//   CustomerWallet.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   GetAllWalletByCustomerByBusinessType? getAllWalletByCustomerByBusinessType;

//   Data({this.getAllWalletByCustomerByBusinessType});

//   Data.fromJson(Map<String, dynamic> json) {
//     getAllWalletByCustomerByBusinessType =
//         json['getAllWalletByCustomerByBusinessType'] != null
//             ? new GetAllWalletByCustomerByBusinessType.fromJson(
//                 json['getAllWalletByCustomerByBusinessType'])
//             : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.getAllWalletByCustomerByBusinessType != null) {
//       data['getAllWalletByCustomerByBusinessType'] =
//           this.getAllWalletByCustomerByBusinessType!.toJson();
//     }
//     return data;
//   }
// }

class GetAllWalletByCustomerByBusinessType {
  bool? error;
  String? msg;
  List<Dataa>? data;
  int? totalWelcomeOfferAmount;

  GetAllWalletByCustomerByBusinessType(
      {this.error, this.msg, this.data, this.totalWelcomeOfferAmount});

  GetAllWalletByCustomerByBusinessType.fromJson(Map<String, dynamic> json) {
    error = json['error'] ?? "";
    msg = json['msg'] ?? "";
    if (json['data'] != null) {
      data = <Dataa>[];
      json['data'].forEach((v) {
        data!.add(new Dataa.fromJson(v));
      });
    }
    totalWelcomeOfferAmount = json['total_welcome_offer_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_welcome_offer_amount'] = this.totalWelcomeOfferAmount;
    return data;
  }
}

class Dataa {
  int? totalStores;
  BusinessType? businessType;
  int? totalWelcomeOfferByBusinessType;
  List<Stores>? stores;

  Dataa(
      {this.totalStores,
      this.businessType,
      this.totalWelcomeOfferByBusinessType,
      this.stores});

  Dataa.fromJson(Map<String, dynamic> json) {
    totalStores = json['total_stores'] ?? "";
    businessType = json['business_type'] != null
        ? new BusinessType.fromJson(json['business_type'])
        : null;
    totalWelcomeOfferByBusinessType =
        json['total_welcome_offer_by_business_type'] ?? "";
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(new Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_stores'] = this.totalStores;
    if (this.businessType != null) {
      data['business_type'] = this.businessType!.toJson();
    }
    data['total_welcome_offer_by_business_type'] =
        this.totalWelcomeOfferByBusinessType;
    if (this.stores != null) {
      data['stores'] = this.stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusinessType {
  String? sId;
  String? name;
  String? type;

  BusinessType({this.sId, this.name, this.type});

  BusinessType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? "";
    name = json['name'] ?? "";
    type = json['type'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class Stores {
  String? sId;
  String? name;
  String? mobile;
  String? logo;
  int? actualWelcomeOffer;
  int? actualCashback;
  String? city;
  int? pincode;
  Address? address;

  Stores(
      {this.sId,
      this.name,
      this.mobile,
      this.logo,
      this.actualWelcomeOffer,
      this.actualCashback,
      this.city,
      this.pincode,
      this.address});

  Stores.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? "";
    name = json['name'] ?? "";
    mobile = json['mobile'] ?? "";
    logo = json['logo'] ?? "";
    actualWelcomeOffer = json['actual_welcome_offer'] ?? "";
    actualCashback = json['actual_cashback'] ?? "";
    city = json['city'] ?? "";
    pincode = json['pincode'] ?? "";
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['logo'] = this.logo;
    data['actual_welcome_offer'] = this.actualWelcomeOffer;
    data['actual_cashback'] = this.actualCashback;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Address {
  Location? location;

  Address({this.location});

  Address.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
