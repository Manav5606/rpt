import 'package:get/get.dart';

import '../../home/models/GetAllCartsModel.dart';

class Cart {
  bool? error;
  String? msg;
  Data? data;

  Cart({this.error, this.msg, this.data});

  Cart.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? total;
  int? totalItemsCount;
  List<Addresses>? addresses;
  double? walletAmount;
  List<Products>? products;
  List<Products>? inventories;
  List<RawItems>? rawItems;
  StoreDoc? storeDoc;
  Data(
      {this.total,
      this.addresses,
      this.totalItemsCount,
      this.walletAmount,
      this.products,
      this.storeDoc,
      this.inventories});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalItemsCount = json['total_items_count'];
    storeDoc = json['storeDoc'] != null
        ? new StoreDoc.fromJson(json['storeDoc'])
        : null;
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
    walletAmount = json['wallet_amount'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['inventories'] != null) {
      inventories = <Products>[];
      json['inventories'].forEach((v) {
        inventories!.add(new Products.fromJson(v));
      });
    }
    if (json['rawitems'] != null) {
      rawItems = <RawItems>[];
      json['rawitems'].forEach((v) {
        rawItems!.add(new RawItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['total_items_count'] = this.totalItemsCount;
    if (this.storeDoc != null) {
      data['storeDoc'] = this.storeDoc!.toJson();
    }
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    data['wallet_amount'] = this.walletAmount;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.inventories != null) {
      data['inventories'] = this.inventories!.map((v) => v.toJson()).toList();
    }
    if (this.rawItems != null) {
      data['rawitems'] = this.rawItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  String? title;
  String? house;
  String? apartment;
  String? sId;
  String? directionToReach;
  String? address;
  num? distance;
  bool? selected;
  Location? location;

  Addresses(
      {this.title,
      this.house,
      this.apartment,
      this.directionToReach,
      this.address,
      this.distance,
      this.selected,
      this.location});

  Addresses.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    sId = json['_id'] == null ? '123456789012' : json['_id'];
    house = json['house'];
    apartment = json['apartment'];
    directionToReach = json['direction_to_reach'];
    address = json['address'];
    distance = json['distance'];
    selected = json['selected'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['house'] = this.house;
    data['_id'] = this.sId;
    data['apartment'] = this.apartment;
    data['direction_to_reach'] = this.directionToReach;
    data['address'] = this.address;
    data['distance'] = this.distance;
    data['selected'] = this.selected;
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

// class Products {
//   String? sId;
//   bool? status;
//
//   Products({this.sId, this.status});
//
//   Products.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['status'] = this.status;
//     return data;
//   }
// }

class Products {
  String? sId;
  bool? status;
  String? name;
  num? mrp;
  num? sellingPrice;
  RxInt? quantity = 0.obs;
  num? cashback;
  num? gstAmount;
  String? logo;
  String? img;
  String? unit;

  Products(
      {this.sId,
      this.status,
      this.name,
      this.mrp,
      this.sellingPrice,
      this.quantity,
      this.cashback,
      this.gstAmount,
      this.logo,
      this.img,
      this.unit});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    name = json['name'];
    logo = json['logo'];
    img = json['img'];
    mrp = json['mrp'];
    sellingPrice = json['selling_price'];
    quantity?.value = json['quantity'];
    cashback = json['cashback'];
    gstAmount = json['gst_amount'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    // data['status'] = this.status;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['img'] = this.img;
    data['mrp'] = this.mrp;
    data['selling_price'] = this.sellingPrice;
    data['quantity'] = this.quantity?.value;
    data['cashback'] = this.cashback;
    data['gst_amount'] = this.gstAmount;
    data['unit'] = this.unit;
    return data;
  }
}
// class Inventory {
//   String? sId;
//   bool? status;
//   String? name;
//   num? mrp;
//   num? sellingPrice;
//   RxInt? quantity = 0.obs;
//   num? cashback;
//   num? gstAmount;

//   Inventory({this.sId, this.status, this.name, this.mrp, this.sellingPrice, this.quantity, this.cashback, this.gstAmount});

//   Inventory.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     status = json['status'];
//     name = json['name'];
//     mrp = json['mrp'];
//     sellingPrice = json['selling_price'];
//     quantity?.value = json['quantity'];
//     cashback = json['cashback'];
//     gstAmount = json['gst_amount'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     // data['status'] = this.status;
//     data['name'] = this.name;
//     data['mrp'] = this.mrp;
//     data['selling_price'] = this.sellingPrice;
//     data['quantity'] = this.quantity?.value;
//     data['cashback'] = this.cashback;
//     data['gst_amount'] = this.gstAmount;
//     return data;
//   }
// }
class StoreDoc {
  int? actualWelcomeOffer;
  int? actualCashback;
  bool? billDiscountOfferStatus;
  int? billDiscountOfferAmount;
  int? billDiscountTargetAmount;
  String? store_type;
  String? name;
  String? id;
  num? distance;

  StoreDoc(
      {this.actualWelcomeOffer,
      this.actualCashback,
      this.billDiscountOfferStatus,
      this.billDiscountOfferAmount,
      this.billDiscountTargetAmount,
      this.store_type,
      this.id,
      this.name,
      this.distance});

  StoreDoc.fromJson(Map<String, dynamic> json) {
    actualWelcomeOffer = json['actual_welcome_offer'];
    actualCashback = json['actual_cashback'];
    store_type = json['store_type'];
    billDiscountOfferStatus = json['bill_discount_offer_status'];
    billDiscountOfferAmount = json['bill_discount_offer_amount'];
    billDiscountTargetAmount = json['bill_discount_offer_target'];
    id = json['_id'];
    name = json['name'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actual_welcome_offer'] = this.actualWelcomeOffer;
    data['actual_cashback'] = this.actualCashback;
    data['store_type'] = this.store_type;
    data['bill_discount_offer_status'] = this.billDiscountOfferStatus;
    data['bill_discount_offer_amount'] = this.billDiscountOfferAmount;
    data['bill_discount_offer_target'] = this.billDiscountTargetAmount;
    data['id'] = this.id;
    data['name'] = this.name;
    data['distance'] = this.distance;
    return data;
  }
}
