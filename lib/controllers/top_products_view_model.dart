import 'package:customer_app/data/models/product_model.dart';
import 'package:get/get.dart';

class TopProductsViewModel extends GetxController {
  var productList = <ProductModelOld>[
    ProductModelOld(
        productId: 21,
        productImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4cSrkIQQ_-PKBVwC0w6gxBiw9_cTGcjEOlw&usqp=CAU',
        productName: 'Big Mac',
        productPrice: 29.99,
        productDescription: '\$1.00 cash back',
        cashBack: 1.5),
    ProductModelOld(
        productId: 22,
        productImage:
            'https://www.mcdonalds.com/content/dam/usa/nfl/nutrition/items/regular/desktop/t-mcdonalds-Fries-Small-Medium.jpg',
        productName: 'McDonalds Fries',
        productPrice: 9.99,
        productDescription: '\$0.75 cash back',
        cashBack: 3),
    ProductModelOld(
        productId: 31,
        productImage:
            'https://recipefairy.com/wp-content/uploads/2020/07/kfc-chicken-500x375.jpg',
        productName: 'Chicken Fry',
        productPrice: 14.99,
        cashBack: 2),
    ProductModelOld(
        productId: 32,
        productImage:
            'https://assets.newatlas.com/dims4/default/7c0af90/2147483647/strip/true/crop/1372x915+0+0/resize/1372x915!/quality/90/?url=http%3A%2F%2Fnewatlas-brightspot.s3.amazonaws.com%2Fb8%2F01%2F42fb621748ceb2a3c56f158d373f%2Fbucket-tenders-laying.jpeg',
        productName: 'Chicken Nuggets',
        productDescription: '\$0.50 cash back',
        productPrice: 12,
        cashBack: 1),
  ].obs;
}
