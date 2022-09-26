class StoresWithProductsModel {
  String? name;
  String? image;
  String? pickup;
  String? delivery;
  String? instoreprices;
  String? latest;
  String? distance;
  String? itemName;
  String? amount;
  String? quantity;
  String? category1;
  String? category2;
  String? category3;
  List<StoreProducts>? products;

  StoresWithProductsModel(
      {required this.name,
      required this.image,
      required this.pickup,
      required this.delivery,
      required this.instoreprices,
      required this.latest,
      required this.distance,
      required this.itemName,
      required this.amount,
      required this.quantity,
      required this.category1,
      required this.category2,
      required this.category3,
      required this.products});
}

class StoreProducts {
  String? image;
  StoreProducts({required this.image});
}
