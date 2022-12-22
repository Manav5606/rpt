class GetOrderConfirmPageData {
  bool? error;
  String? msg;
  Data? data;

  GetOrderConfirmPageData({this.error, this.msg, this.data});

  GetOrderConfirmPageData.fromJson(Map<String, dynamic> json) {
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
  num? previousTotalAmount;
  int? totalGstAmount;
  num? usedWalletAmount;
  num? total;
  num? finalpayableAmount;
  int? gstAndPackaging;
  int? packagingFee;
  int? deliveryFee;
  List<DeliverySlots>? deliverySlots;
  num? walletAmount;
  int? billDiscountOfferAmount;
  bool? billDiscountOfferStatus;
  int? billDiscountOfferTarget;
  // BillDiscountOfferDate? billDiscountOfferDate;

  Data(
      {this.previousTotalAmount,
      this.finalpayableAmount,
      this.totalGstAmount,
      this.usedWalletAmount,
      this.total,
      this.gstAndPackaging,
      this.packagingFee,
      this.deliveryFee,
      this.deliverySlots,
      this.walletAmount,
      this.billDiscountOfferAmount,
      this.billDiscountOfferStatus,
      this.billDiscountOfferTarget
      // this.billDiscountOfferDate
      });

  Data.fromJson(Map<String, dynamic> json) {
    previousTotalAmount = json['previous_total_amount'];
    totalGstAmount = json['total_gst_amount'];
    usedWalletAmount = json['used_wallet_amount'];
    finalpayableAmount = json['final_payable_amount'];
    total = json['total'];
    gstAndPackaging = json['gst_and_packaging'];
    packagingFee = json['packaging_fee'];
    deliveryFee = json['delivery_fee'];
    if (json['delivery_slots'] != null) {
      deliverySlots = <DeliverySlots>[];
      json['delivery_slots'].forEach((v) {
        deliverySlots!.add(new DeliverySlots.fromJson(v));
      });
    }
    walletAmount = json['wallet_amount'];
    billDiscountOfferAmount = json['bill_discount_offer_amount'];
    billDiscountOfferStatus = json['bill_discount_offer_status'];
    billDiscountOfferTarget = json['bill_discount_offer_target'];
    // billDiscountOfferDate = json['bill_discount_offer_date'] != null
    //     ? new BillDiscountOfferDate.fromJson(json['bill_discount_offer_date'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['previous_total_amount'] = this.previousTotalAmount;
    data['total_gst_amount'] = this.totalGstAmount;
    data['final_payable_amount'] = this.finalpayableAmount;
    data['used_wallet_amount'] = this.usedWalletAmount;
    data['total'] = this.total;
    data['gst_and_packaging'] = this.gstAndPackaging;
    data['packaging_fee'] = this.packagingFee;
    data['delivery_fee'] = this.deliveryFee;
    if (this.deliverySlots != null) {
      data['delivery_slots'] =
          this.deliverySlots!.map((v) => v.toJson()).toList();
    }
    data['wallet_amount'] = this.walletAmount;
    data['bill_discount_offer_amount'] = this.billDiscountOfferAmount;
    data['bill_discount_offer_status'] = this.billDiscountOfferStatus;
    data['bill_discount_offer_target'] = this.billDiscountOfferTarget;
    // if (this.billDiscountOfferDate != null) {
    //   data['bill_discount_offer_date'] = this.billDiscountOfferDate!.toJson();
    // }
    return data;
  }
}

class DeliverySlots {
  String? sId;
  int? day;
  List<Slots>? slots;
  bool? status;

  DeliverySlots({this.sId, this.day, this.slots, this.status});

  DeliverySlots.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    day = json['day'];
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(new Slots.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['day'] = this.day;
    if (this.slots != null) {
      data['slots'] = this.slots!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Slots {
  String? sId;
  StartTime? startTime;
  StartTime? cutOffTime;
  StartTime? endTime;
  bool? status;

  Slots({this.sId, this.startTime, this.cutOffTime, this.endTime, this.status});

  Slots.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    startTime = json['start_time'] != null
        ? new StartTime.fromJson(json['start_time'])
        : null;
    cutOffTime = json['cut_off_time'] != null
        ? new StartTime.fromJson(json['cut_off_time'])
        : null;
    endTime = json['end_time'] != null
        ? new StartTime.fromJson(json['end_time'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.startTime != null) {
      data['start_time'] = this.startTime!.toJson();
    }
    if (this.cutOffTime != null) {
      data['cut_off_time'] = this.cutOffTime!.toJson();
    }
    if (this.endTime != null) {
      data['end_time'] = this.endTime!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class StartTime {
  int? hour;
  int? minute;

  StartTime({this.hour, this.minute});

  StartTime.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    minute = json['minute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    return data;
  }
}

class DayTimeSlots {
  int? day;
  StartTime? cutOffTime;
  StartTime? startTime;
  StartTime? endTime;

  DayTimeSlots({this.day, this.startTime, this.endTime, this.cutOffTime});

  DayTimeSlots.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    cutOffTime = json['cut_off_time'] != null
        ? new StartTime.fromJson(json['cut_off_time'])
        : null;
    startTime = json['start_time'] != null
        ? new StartTime.fromJson(json['start_time'])
        : null;
    endTime = json['end_time'] != null
        ? new StartTime.fromJson(json['end_time'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.cutOffTime != null) {
      data['cut_off_time'] = this.cutOffTime!.toJson();
    }

    if (this.startTime != null) {
      data['start_time'] = this.startTime!.toJson();
    }
    if (this.endTime != null) {
      data['end_time'] = this.endTime!.toJson();
    }
    return data;
  }
}
// class BillDiscountOfferDate {
//   String? startDate;
//   String? endDate;

//   BillDiscountOfferDate({this.startDate, this.endDate});

//   BillDiscountOfferDate.fromJson(Map<String, dynamic> json) {
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['start_date'] = this.startDate;
//     data['end_date'] = this.endDate;
//     return data;
//   }
// }
