import 'package:get/get.dart';

class GetAllCartsModel {
  bool? error;
  String? msg;
  int? cartItemsTotal;
  List<Carts>? carts;

  GetAllCartsModel({this.error, this.msg, this.cartItemsTotal, this.carts});

  GetAllCartsModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    cartItemsTotal = json['cartItemsTotal'];
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(new Carts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    data['cartItemsTotal'] = this.cartItemsTotal;
    if (this.carts != null) {
      data['carts'] = this.carts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Carts {
  String? sId;
  RxInt? totalItemsCount = 0.obs;
  Store? store;
  List<AllCartProducts>? products;
  List<RawItems>? rawItems;

  Carts({this.sId, this.totalItemsCount, this.store});

  Carts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    totalItemsCount?.value = json['total_items_count'] != null ? json['total_items_count'] : 0;
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    if (json['products'] != null) {
      products = <AllCartProducts>[];
      json['products'].forEach((v) {
        products!.add(new AllCartProducts.fromJson(v));
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
    data['_id'] = this.sId;
    data['total_items_count'] = this.totalItemsCount!.value;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.rawItems != null) {
      data['rawitems'] = this.rawItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Store {
  String? sId;
  String? name;
  String? logo;
  String? storeType;
  String? businesstype;
  int? earnedCashback;

  Store({this.sId, this.name, this.logo, this.earnedCashback, this.businesstype});

  Store.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    logo = json['logo'];
    earnedCashback = json['earned_cashback'];
    storeType = json['store_type'];
    businesstype = json['businesstype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['store_type'] = this.storeType;
    data['earned_cashback'] = this.earnedCashback;
    data['businesstype'] = this.businesstype;
    return data;
  }
}

class AllCartProducts {
  String? sId;
  int? quantity;

  AllCartProducts({this.sId, this.quantity});

  AllCartProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['quantity'] = this.quantity;
    return data;
  }
}

class RawItems {
  String? item;
  String? unit;
  String? logo;
  RxInt? quantity = 0.obs;
  String? sId;

  RawItems({this.item, this.quantity, this.sId ,this.unit , this.logo});

  RawItems.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    unit = json['unit'];
    logo = json['logo'];
    quantity?.value = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    data['unit'] = this.unit;
    data['logo'] = this.logo;
    data['quantity'] = this.quantity?.value;
    // data['_id'] = this.sId;
    return data;
  }
}
