import 'package:get/get.dart';

class GetStoreDataModel {
  bool? error;
  String? msg;
  Data? data;

  GetStoreDataModel({this.error, this.msg, this.data});

  GetStoreDataModel.fromJson(Map<String, dynamic> json) {
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
  Store? store;
  num? walletAmount;

  List<MainProducts>? mainProducts;

  Data({
    this.store,
    this.walletAmount,
    this.mainProducts,
  });

  Data.fromJson(Map<String, dynamic> json) {
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    walletAmount = json['wallet_amount'];
    if (json['products'] != null) {
      mainProducts = <MainProducts>[];
      json['products'].forEach((v) {
        mainProducts!.add(new MainProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    data['wallet_amount'] = this.walletAmount;
    if (this.mainProducts != null) {
      data['products'] = this.mainProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Store {
  String? name;
  String? storeType;
  String? color;
  String? sId;
  int? defaultCashback;
  int? defaultWelcomeOffer;
  num? actual_cashback;
  num? actual_welcome_offer;
  int? promotionCashback;
  String? logo;
  List<DeliverySlots>? deliverySlots;
  int? bill_discount_offer_amount;
  bool? bill_discount_offer_status;
  int? bill_discount_offer_target;
  RefernAndEarn? refernAndEarn;
  RefernAndEarn? leadGenerationPromotion;

  Store(
      {this.name,
      this.storeType,
      this.color,
      this.defaultCashback,
      this.defaultWelcomeOffer,
      this.promotionCashback,
      this.actual_cashback,
      this.actual_welcome_offer,
      this.logo,
      this.deliverySlots,
      this.sId,
      this.bill_discount_offer_amount,
      this.bill_discount_offer_status,
      this.bill_discount_offer_target,
      this.leadGenerationPromotion,
      this.refernAndEarn});

  Store.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sId = json['_id'];
    storeType = json['store_type'];
    color = json['color'];
    defaultCashback = json['default_cashback'];
    defaultWelcomeOffer = json['default_welcome_offer'];
    promotionCashback = json['promotion_cashback'];
    actual_cashback = json['actual_cashback'];
    actual_welcome_offer = json['actual_welcome_offer'] ?? 0;
    logo = json['logo'];
    bill_discount_offer_amount = json['bill_discount_offer_amount'] ?? 0;
    bill_discount_offer_status = json['bill_discount_offer_status'];
    bill_discount_offer_target = json['bill_discount_offer_target'] ?? 0;
    refernAndEarn = json['refern_and_earn'] != null
        ? new RefernAndEarn.fromJson(json['refern_and_earn'])
        : null;
    leadGenerationPromotion = json['lead_generation_promotion'] != null
        ? new RefernAndEarn.fromJson(json['lead_generation_promotion'])
        : null;
    if (json['delivery_slots'] != null) {
      deliverySlots = <DeliverySlots>[];
      json['delivery_slots'].forEach((v) {
        deliverySlots!.add(new DeliverySlots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['_id'] = this.sId;
    data['color'] = this.color;
    data['store_type'] = this.storeType;
    data['actual_cashback'] = this.actual_cashback;
    data['actual_welcome_offer'] = this.actual_welcome_offer;
    data['default_cashback'] = this.defaultCashback;
    data['default_welcome_offer'] = this.defaultWelcomeOffer;
    data['promotion_cashback'] = this.promotionCashback;
    data['bill_discount_offer_amount'] = this.bill_discount_offer_amount;
    data['bill_discount_offer_status'] = this.bill_discount_offer_status;
    data['bill_discount_offer_target'] = this.bill_discount_offer_target;
    data['logo'] = this.logo;
    if (this.refernAndEarn != null) {
      data['refern_and_earn'] = this.refernAndEarn!.toJson();
    }
    if (this.leadGenerationPromotion != null) {
      data['lead_generation_promotion'] =
          this.leadGenerationPromotion!.toJson();
    }
    if (this.deliverySlots != null) {
      data['delivery_slots'] =
          this.deliverySlots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RefernAndEarn {
  bool? status;
  int? amount;

  RefernAndEarn({this.status, this.amount});

  RefernAndEarn.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['amount'] = this.amount;
    return data;
  }
}

class DeliverySlots {
  int? day;
  List<Slots>? slots;

  DeliverySlots({this.day, this.slots});

  DeliverySlots.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(new Slots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.slots != null) {
      data['slots'] = this.slots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slots {
  StartTime? startTime;
  StartTime? endTime;

  Slots({this.startTime, this.endTime});

  Slots.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'] != null
        ? new StartTime.fromJson(json['start_time'])
        : null;
    endTime = json['end_time'] != null
        ? new StartTime.fromJson(json['end_time'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.startTime != null) {
      data['start_time'] = this.startTime!.toJson();
    }
    if (this.endTime != null) {
      data['end_time'] = this.endTime!.toJson();
    }
    return data;
  }
}

class StartTime {
  int? hour;

  StartTime({this.hour});

  StartTime.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    return data;
  }
}

class MainProducts {
  String? sId;
  String? name;
  List<StoreModelProducts>? products;

  MainProducts({this.sId, this.name, this.products});

  MainProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['products'] != null) {
      products = <StoreModelProducts>[];
      json['products'].forEach((v) {
        products!.add(new StoreModelProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreModelProducts {
  String? sId;
  String? name;
  String? logo;
  num? mrp;
  String? unit;
  num? selling_price;
  num? cashback;
  RxInt? quntity = 0.obs;
  RxBool? isQunitityAdd = false.obs;

  StoreModelProducts(
      {this.sId,
      this.name,
      this.logo,
      this.mrp,
      this.unit,
      this.selling_price,
      this.cashback = 0,
      this.quntity,
      this.isQunitityAdd});

  StoreModelProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    logo = json['logo'];
    mrp = json['mrp'];
    unit = json['unit'];
    selling_price = json['selling_price'];
    cashback = json['cashback'];
    quntity?.value = json['quantity'] != null ? 0 : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    // data['logo'] = this.logo;
    data['cashback'] = this.cashback;
    data['quantity'] = this.quntity!.value;
    return data;
  }
}
