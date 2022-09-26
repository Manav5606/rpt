class OrderQueryModel {
  String? title;
  String? orderNo;
  String? datetime;
  String? status;
  OrderQueryModel(
      {required this.title,
      required this.orderNo,
      required this.datetime,
      required this.status});
}
