import 'package:customer_app/data/models/product_model.dart';

class CartModel {
  ProductModelOld? product;
  int count;

  CartModel({this.product, this.count = 1});
}
