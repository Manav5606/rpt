// class GetCartPageInformation {
//   bool? error;
//   String? msg;
//   Data? data;

//   GetCartPageInformation({this.error, this.msg, this.data});

//   GetCartPageInformation.fromJson(Map<String, dynamic> json) {
//     error = json['error'];
//     msg = json['msg'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['error'] = this.error;
//     data['msg'] = this.msg;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   bool? billDiscountOfferStatus;
//   int? billDiscountOfferTarget;
//   int? billDiscountOfferAmount;
//   int? walletAmount;
//   List<DeliverySlot>? deliverySlots;

//   Data(
//       {this.billDiscountOfferStatus,
//       this.billDiscountOfferTarget,
//       this.billDiscountOfferAmount,
//       this.walletAmount,
//       this.deliverySlots});

//   Data.fromJson(Map<String, dynamic> json) {
//     billDiscountOfferStatus = json['bill_discount_offer_status'];
//     billDiscountOfferTarget = json['bill_discount_offer_target'];
//     billDiscountOfferAmount = json['bill_discount_offer_amount'];
//     walletAmount = json['wallet_amount'];
//     if (json['delivery_slots'] != null) {
//       deliverySlots = <DeliverySlot>[];
//       json['delivery_slots'].forEach((v) {
//         deliverySlots!.add(new DeliverySlot.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['bill_discount_offer_status'] = this.billDiscountOfferStatus;
//     data['bill_discount_offer_target'] = this.billDiscountOfferTarget;
//     data['bill_discount_offer_amount'] = this.billDiscountOfferAmount;
//     data['wallet_amount'] = this.walletAmount;
//     if (this.deliverySlots != null) {
//       data['delivery_slots'] =
//           this.deliverySlots!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class DeliverySlot {
//   String? sId;
//   int? day;
//   List<TimeSlots>? slots;

//   DeliverySlot({this.sId, this.day, this.slots});

//   DeliverySlot.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     day = json['day'];
//     if (json['slots'] != null) {
//       slots = <TimeSlots>[];
//       json['slots'].forEach((v) {
//         slots!.add(new TimeSlots.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['day'] = this.day;
//     if (this.slots != null) {
//       data['slots'] = this.slots!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class TimeSlots {
//   // String? sId;
//   CutOffTime? cutOffTime;
//   CutOffTime? startTime;
//   CutOffTime? endTime;

//   TimeSlots({this.startTime, this.endTime});

//   TimeSlots.fromJson(Map<String, dynamic> json) {
//     // sId = json['_id'];
//     cutOffTime = json['cut_off_time'] != null
//         ? new CutOffTime.fromJson(json['cut_off_time'])
//         : null;
//     startTime = json['start_time'] != null
//         ? new CutOffTime.fromJson(json['start_time'])
//         : null;
//     endTime = json['end_time'] != null
//         ? new CutOffTime.fromJson(json['end_time'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     // data['_id'] = this.sId;
//     if (this.cutOffTime != null) {
//       data['cut_off_time'] = this.cutOffTime!.toJson();
//     }
//     if (this.startTime != null) {
//       data['start_time'] = this.startTime!.toJson();
//     }
//     if (this.endTime != null) {
//       data['end_time'] = this.endTime!.toJson();
//     }
//     return data;
//   }
// }

// class CutOffTime {
//   int? hour;
//   int? minute;

//   CutOffTime({this.hour, this.minute});

//   CutOffTime.fromJson(Map<String, dynamic> json) {
//     hour = json['hour'];
//     minute = json['minute'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['hour'] = this.hour;
//     data['minute'] = this.minute;
//     return data;
//   }
// }

// // class DayTimeSlots {
// //   int? day;
// //   CutOffTime? cutOffTime;
// //   CutOffTime? startTime;
// //   CutOffTime? endTime;

// //   DayTimeSlots({this.day, this.startTime, this.endTime, this.cutOffTime});

// //   DayTimeSlots.fromJson(Map<String, dynamic> json) {
// //     day = json['day'];
// //     cutOffTime = json['cut_off_time'] != null
// //         ? new CutOffTime.fromJson(json['cut_off_time'])
// //         : null;
// //     startTime = json['start_time'] != null
// //         ? new CutOffTime.fromJson(json['start_time'])
// //         : null;
// //     endTime = json['end_time'] != null
// //         ? new CutOffTime.fromJson(json['end_time'])
// //         : null;
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['day'] = this.day;
// //     if (this.cutOffTime != null) {
// //       data['cut_off_time'] = this.cutOffTime!.toJson();
// //     }

// //     if (this.startTime != null) {
// //       data['start_time'] = this.startTime!.toJson();
// //     }
// //     if (this.endTime != null) {
// //       data['end_time'] = this.endTime!.toJson();
// //     }
// //     return data;
// //   }
// // }
