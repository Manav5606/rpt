class RedeemBalanceModel {
  bool? error;
  String? msg;
  int? expBalance;
  int? actBalance;

  RedeemBalanceModel({this.error, this.msg, this.expBalance, this.actBalance});

  RedeemBalanceModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    expBalance = json['expBalance'];
    actBalance = json['actBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    data['expBalance'] = this.expBalance;
    data['actBalance'] = this.actBalance;
    return data;
  }
}
