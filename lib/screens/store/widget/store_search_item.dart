import 'package:customer_app/app/ui/pages/search/models/GetStoreDataModel.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/assets_constants.dart';
import 'package:customer_app/screens/store/widget/quantity_dropdown.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:flutter/material.dart';

class StoreSearchItem extends StatelessWidget {
  final StoreModelProducts product;

  const StoreSearchItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            product.logo ?? AssetsContants.placholder,
            height: 50,
            width: 50,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${product.name}",
                style: AppTextStyle.h4Bold(),
                maxLines: 2,
              ),
              SizedBox(height: 3),
              Text(
                "${product.cashback}",
                style: AppTextStyle.h6Regular(color: AppConst.grey),
              ),
            ],
          ),
        ),
        QuantityDropdown(
            defaultSelected: 0,
            onChanged: (value) {
              // item.quntity!.value = value;
              // if (item.quntity!.value == 0) {
              //   item.isQunitityAdd?.value = false;
              // }
              // _moreStoreController.addToCart(
              //   store_id: item.sId!,
              //   index: 0,
              //   increment: true,
              //   product: item,
              //   cart_id:
              //       _moreStoreController.addToCartModel.value?.sId ?? '',
              // );
              // totalCalculated();
            }),
      ]),
    );
  }
}
