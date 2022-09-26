class CreateRazorpayResponse {
  String? orderId;
  int? amount;

  CreateRazorpayResponse({this.orderId, this.amount});

  CreateRazorpayResponse.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['amount'] = this.amount;
    return data;
  }
}
