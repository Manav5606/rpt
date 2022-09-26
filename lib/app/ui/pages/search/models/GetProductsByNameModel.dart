class GetProductsByName {
  bool? error;
  String? msg;
  Data? data;

  GetProductsByName({this.error, this.msg, this.data});

  GetProductsByName.fromJson(Map<String, dynamic> json) {
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
  List<ProductsData>? products;
  List<Inventories>? inventories;

  Data({this.products, this.inventories});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <ProductsData>[];
      json['products'].forEach((v) {
        products!.add(new ProductsData.fromJson(v));
      });
    }
    if (json['inventories'] != null) {
      inventories = <Inventories>[];
      json['inventories'].forEach((v) {
        inventories!.add(new Inventories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.inventories != null) {
      data['inventories'] = this.inventories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductsData {
  String? sId;
  String? name;
  int? cashback;
  Store? store;

  ProductsData({this.sId, this.name, this.cashback, this.store});

  ProductsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    cashback = json['cashback'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['cashback'] = this.cashback;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    return data;
  }
}

class Store {
  String? sId;
  String? name;
  String? logo;
  int? defaultCashback;
  num? calculatedDistance;
  String? storeType;
  bool? premium;

  Store(
      {this.sId,
      this.name,
      this.logo,
      this.defaultCashback,
      this.calculatedDistance,
      this.storeType,
      this.premium});

  Store.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    logo = json['logo'];
    defaultCashback = json['default_cashback'];
    calculatedDistance = json['calculated_distance'];
    storeType = json['store_type'];
    premium = json['premium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['default_cashback'] = this.defaultCashback;
    data['calculated_distance'] = this.calculatedDistance;
    data['store_type'] = this.storeType;
    data['premium'] = this.premium;
    return data;
  }
}

class Inventories {
  String? sId;
  String? name;
  InventoriesStore? store;

  Inventories({this.sId, this.name, this.store});

  Inventories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    store = json['store'] != null
        ? new InventoriesStore.fromJson(json['store'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    return data;
  }
}

class InventoriesStore {
  String? sId;
  String? name;
  String? logo;
  int? defaultCashback;
  Null calculatedDistance;
  String? storeType;
  bool? premium;

  InventoriesStore(
      {this.sId,
      this.name,
      this.logo,
      this.defaultCashback,
      this.calculatedDistance,
      this.storeType,
      this.premium});

  InventoriesStore.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    logo = json['logo'];
    defaultCashback = json['default_cashback'];
    calculatedDistance = json['calculated_distance'];
    storeType = json['store_type'];
    premium = json['premium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['default_cashback'] = this.defaultCashback;
    data['calculated_distance'] = this.calculatedDistance;
    data['store_type'] = this.storeType;
    data['premium'] = this.premium;
    return data;
  }
}
