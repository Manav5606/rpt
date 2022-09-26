import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:customer_app/widgets/button.dart';

import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_resources.dart';
import 'package:customer_app/data/models/mixed/productModel.dart';
import 'package:customer_app/utils/ui_spacing_helper.dart';
import 'package:customer_app/widgets/copied/circle_image_widget.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel? data;
  final bool? isAdded;
  final Function? onAdd;
  final Function? onIncrementCount;
  final Function? onDecrementCount;
  final Function? onDelete;
  final String? address;
  final String? storeName;
  final double? distance;

  const ProductCardWidget(
      {Key? key,
      this.data,
      this.onAdd,
      this.isAdded = false,
      this.onIncrementCount,
      this.onDecrementCount,
      this.address,
      this.distance,
      this.storeName,
      this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: AppConst.white,
          border:
              Border.all(width: 1, color: AppConst.darkGrey.withOpacity(0.15)),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [AppConst.shadowBasic2]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ImageFromNetwork(
              image: data!.logo!,
              decoration: BoxDecoration(),
            ),
          ),
          Divider(
            thickness: 1,
            color: AppConst.lightGrey,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(data!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppConst.body),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                data!.cashbackPercentage != null
                    ? ("Cashback: " +
                        data!.cashback!.toStringAsFixed(1) +
                        StringResources.rupee)
                    : "",
                style: AppConst.descriptionTextRed,
              ),
              UISpacingHelper.verticalSpaceSmall,
              Text(
                data!.store != null
                    ? ("Store: " + (storeName ?? "No Store Name"))
                    : "",
                style: AppConst.descriptionTextRed,
              ),
              UISpacingHelper.verticalSpaceSmall,
              (address != null)
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        "Address: " + address!,
                        style: AppConst.descriptionTextRed,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    )
                  : Container(),
              (distance != null)
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        "Distance: " + (distance)!.toStringAsFixed(1) + " KM",
                        style: AppConst.descriptionTextRed,
                      ),
                    )
                  : Container(),
              Text(
                data!.sellingPrice.toString() + StringResources.rupee,
                style: AppConst.titleText1Purple,
              ),
              Visibility(
                  visible: isAdded!,
                  child: Container(
                      margin: const EdgeInsets.only(top: 12.0),
                      child: BaseButton(
                        title: "Add to cart",
                        enabled: true,
                        height: 38.0,
                        onTap: () {
                          onAdd?.call();
                        },
                      ))),
              /*        Visibility(
                  visible: isAdded!,
                  child: Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    child: CartCounterwidget(
                      value: data!.quantity!,
                      onDecrementCount: onDecrementCount!,
                      onDelete: onDelete!,
                      onIncrementCount: onIncrementCount!,
                    ),
                  )),*/
            ],
          )
        ],
      ),
    );
  }
}

class ProductRecommendationCardWidget extends StatelessWidget {
  final String? name;
  final String? imagePath;
  final num? cashback;

  ProductRecommendationCardWidget(
      {Key? key, @required this.name, @required this.imagePath, this.cashback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: AppConst.white,
          border:
              Border.all(width: 1, color: AppConst.darkGrey.withOpacity(0.15)),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [AppConst.shadowBasic]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80.0,
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ImageFromNetwork(
              image: imagePath!,
              decoration: BoxDecoration(),
            ),
          ),
          Divider(
            thickness: 1,
            color: AppConst.lightGrey,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppConst.body),
                UISpacingHelper.verticalSpaceSmall,
                Text(
                  cashback != null
                      ? ('Cashback : ${cashback!.toStringAsFixed(1)}' +
                          StringResources.rupee)
                      : "",
                  style: AppConst.titleText1Purple,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
