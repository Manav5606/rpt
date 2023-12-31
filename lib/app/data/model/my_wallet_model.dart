class MyWalletModel {
  GetAllWalletByCustomer? getAllWalletByCustomer;

  MyWalletModel({this.getAllWalletByCustomer});

  MyWalletModel.fromJson(Map<String, dynamic> json) {
    getAllWalletByCustomer = json['getAllWalletByCustomer'] != null
        ? new GetAllWalletByCustomer.fromJson(json['getAllWalletByCustomer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getAllWalletByCustomer != null) {
      data['getAllWalletByCustomer'] = this.getAllWalletByCustomer!.toJson();
    }
    return data;
  }
}

class GetAllWalletByCustomer {
  bool? error;
  String? msg;
  List<WalletData>? data;

  GetAllWalletByCustomer({this.error, this.msg, this.data});

  GetAllWalletByCustomer.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <WalletData>[];
      json['data'].forEach((v) {
        data!.add(new WalletData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletData {
  bool? recentlyVisited;
  String? sId;
  int? welcomeOffer;
  int? welcomeOfferAmount;
  num? earnedCashback;
  String? user;
  String? password;
  String? name;
  bool? premium;
  List<TotalCashbackSubBusinessType>? totalCashbackSubBusinessType;
  String? logo;
  int? defaultCashback;
  int? defaultWelcomeOffer;
  int? promotionCashback;
  String? status;
  String? promotionWelcomeOfferStatus;
  String? promotionCashbackStatus;
  Null flag;
  String? createdAt;
  String? updatedAt;
  String? storeType;
  int? distance;
  bool? online;
  double? calculatedDistance;
  Null customerWalletAmount;
  bool? lead;
  int? leadWelcomeOffer; // int
  Address? address;
  bool? deactivated;
  Businesstype? businesstype;

  WalletData(
      {this.recentlyVisited,
      this.sId,
      this.welcomeOffer,
      this.welcomeOfferAmount,
      this.earnedCashback,
      this.user,
      this.password,
      this.name,
      this.premium,
      this.logo,
      this.defaultCashback,
      this.defaultWelcomeOffer,
      this.promotionCashback,
      this.status,
      this.promotionWelcomeOfferStatus,
      this.promotionCashbackStatus,
      this.flag,
      this.createdAt,
      this.updatedAt,
      this.storeType,
      this.distance,
      this.online,
      this.calculatedDistance,
      this.customerWalletAmount,
      this.lead,
      this.leadWelcomeOffer,
      this.address,
      this.deactivated,
      this.businesstype});

  WalletData.fromJson(Map<String, dynamic> json) {
    recentlyVisited = json['recently_visited'];
    sId = json['_id'];
    welcomeOffer = json['welcome_offer'];
    welcomeOfferAmount = json['welcome_offer_amount'] ?? 0;
    earnedCashback = json['earned_cashback'] ?? 0;
    user = json['user'];
    password = json['password'];
    name = json['name'];
    premium = json['premium'];
     if (json['total_cashback_sub_business_type'] != null) {
      totalCashbackSubBusinessType = <TotalCashbackSubBusinessType>[];
      json['total_cashback_sub_business_type'].forEach((v) {
        totalCashbackSubBusinessType!
            .add(new TotalCashbackSubBusinessType.fromJson(v));
      });
    }
    logo = json['logo'];
    defaultCashback = json['default_cashback'];
    defaultWelcomeOffer = json['default_welcome_offer'];
    promotionCashback = json['promotion_cashback'];
    status = json['status'];
    promotionWelcomeOfferStatus = json['promotion_welcome_offer_status'];
    promotionCashbackStatus = json['promotion_cashback_status'];
    flag = json['flag'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    storeType = json['store_type'];
    distance = json['distance'];
    online = json['online'];
    calculatedDistance = json['calculated_distance'];
    customerWalletAmount = json['customer_wallet_amount'];
    lead = json['lead'];
    leadWelcomeOffer = json['lead_welcome_offer'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    deactivated = json['deactivated'];
    businesstype = json['businesstype'] != null
        ? new Businesstype.fromJson(json['businesstype'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recently_visited'] = this.recentlyVisited;
    data['_id'] = this.sId;
    data['welcome_offer'] = this.welcomeOffer;
    data['welcome_offer_amount'] = this.welcomeOfferAmount;
    data['earned_cashback'] = this.earnedCashback;
    data['user'] = this.user;
    data['password'] = this.password;
    data['name'] = this.name;
    data['premium'] = this.premium;
    if (this.totalCashbackSubBusinessType != null) {
      data['total_cashback_sub_business_type'] =
          this.totalCashbackSubBusinessType!.map((v) => v.toJson()).toList();
    }
    data['logo'] = this.logo;
    data['default_cashback'] = this.defaultCashback;
    data['default_welcome_offer'] = this.defaultWelcomeOffer;
    data['promotion_cashback'] = this.promotionCashback;
    data['status'] = this.status;
    data['promotion_welcome_offer_status'] = this.promotionWelcomeOfferStatus;
    data['promotion_cashback_status'] = this.promotionCashbackStatus;
    data['flag'] = this.flag;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['store_type'] = this.storeType;
    data['distance'] = this.distance;
    data['online'] = this.online;
    data['calculated_distance'] = this.calculatedDistance;
    data['customer_wallet_amount'] = this.customerWalletAmount;
    data['lead'] = this.lead;
    data['lead_welcome_offer'] = this.leadWelcomeOffer;
    data['address'] = this.address!.toJson();
    data['deactivated'] = this.deactivated;
    if (this.businesstype != null) {
      data['businesstype'] = this.businesstype!.toJson();
    }
    return data;
  }
}

class Businesstype {
  String? sId;

  Businesstype({this.sId});

  Businesstype.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['_id'] = this.sId;
    return data;
  }
}
class TotalCashbackSubBusinessType {
  String? sTypename;
  String? subBusinessType;

  TotalCashbackSubBusinessType({this.sTypename, this.subBusinessType});

  TotalCashbackSubBusinessType.fromJson(Map<String, dynamic> json) {
 
    subBusinessType = json['sub_business_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['sub_business_type'] = this.subBusinessType;
    return data;
  }
}

class Address {
  String? address;

  Address({this.address});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    return data;
  }
}

class MyWalletTransactionModel {
  GetAllWalletTransactionByCustomer? getAllWalletTransactionByCustomer;

  MyWalletTransactionModel({this.getAllWalletTransactionByCustomer});

  MyWalletTransactionModel.fromJson(Map<String, dynamic> json) {
    getAllWalletTransactionByCustomer =
        json['getAllWalletTransactionByCustomer'] != null
            ? new GetAllWalletTransactionByCustomer.fromJson(
                json['getAllWalletTransactionByCustomer'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getAllWalletTransactionByCustomer != null) {
      data['getAllWalletTransactionByCustomer'] =
          this.getAllWalletTransactionByCustomer!.toJson();
    }
    return data;
  }
}

class GetAllWalletTransactionByCustomer {
  bool? error;
  String? msg;
  List<Transaction>? data;

  GetAllWalletTransactionByCustomer({this.error, this.msg, this.data});

  GetAllWalletTransactionByCustomer.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Transaction>[];
      json['data'].forEach((v) {
        data!.add(new Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  num? amount;
  String? debitOrCredit;
  String? comment;
  String? createdAt;
  // Store? store;

  Transaction(
      {this.amount,
      this.debitOrCredit,
      this.comment,
      // this.store,
      this.createdAt});

  Transaction.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    debitOrCredit = json['debit_or_credit'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    // store = json['store'] != null ? new Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['debit_or_credit'] = this.debitOrCredit;
    data['comment'] = this.comment;
    data['createdAt'] = this.createdAt;
    // if (this.store != null) {
    //   data['store'] = this.store!.toJson();
    // }

    return data;
  }
}

// class Store {
//   String? name;
//   String? logo;

//   Store({this.name, this.logo});

//   Store.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     logo = json['logo'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['logo'] = this.logo;
//     return data;
//   }
// }
