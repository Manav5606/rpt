class GetClaimRewardsPageCountModel {
  int? storesCount;
  int? totalCashBack;

  GetClaimRewardsPageCountModel({this.storesCount, this.totalCashBack});

  GetClaimRewardsPageCountModel.fromJson(Map<String, dynamic> json) {
    storesCount = json['storesCount'];
    totalCashBack = json['totalCashBack'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storesCount'] = this.storesCount;
    data['totalCashBack'] = this.totalCashBack;
    return data;
  }
}
