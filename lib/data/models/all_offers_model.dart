class AllOffersModel {
  String name;
  String image;
  double distance;
  String? pickup;
  String? delivery;
  String? storePrices;

  AllOffersModel(
      {required this.distance,
      required this.name,
      required this.image,
      required this.delivery,
      required this.pickup,
      required this.storePrices});
}
