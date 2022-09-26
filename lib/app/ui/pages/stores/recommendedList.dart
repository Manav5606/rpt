import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/cartController.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/data/storeswithproductmodel.dart';
import 'package:customer_app/data/storeswithproductsdata.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/addButton.dart';
import 'package:get/get.dart';

class RecommendedList extends StatelessWidget {
  final ScrollController? controller;
  RecommendedList({Key? key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: this.controller,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: storesWithProductsData.length, //data.length,
      itemBuilder: (context, index) {
        return ListViewChild(
          storesWithProductsModel: storesWithProductsData[index],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: SizeUtils.horizontalBlockSize * 2.55,
        );
      },
    );
  }
}

class ListViewChild extends StatelessWidget {
  final CartController cartData = Get.find();

  final StoresWithProductsModel storesWithProductsModel;
  ListViewChild({Key? key, required this.storesWithProductsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 2.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Frequently bought with",
                style: AppStyles.STORE_NAME_STYLE,
              ),
              Text("blueberris"),
            ],
          ),
        ),
        SizedBox(
          height: SizeUtils.horizontalBlockSize * 1.27,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: SizeUtils.horizontalBlockSize * 80,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                    0, SizeUtils.horizontalBlockSize * 2.55, 0, 0),
                child: ListView.separated(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: storesWithProductsModel.products!.length,
                  itemBuilder: (context, index) {
                    StoreProducts product =
                        storesWithProductsModel.products![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: SizeUtils.horizontalBlockSize * 52,
                          width: SizeUtils.horizontalBlockSize * 40,
                          child: Stack(clipBehavior: Clip.none, children: [
                            Positioned(
                              right: -SizeUtils.horizontalBlockSize * 2,
                              child: Obx(() => (cartData.items! < 1)
                                  ? InkWell(
                                      onTap: () => cartData.increment(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: AppConst.green),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: AppConst.green,
                                          size:
                                              SizeUtils.horizontalBlockSize * 8,
                                        ),
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        InkWell(
                                          onTap: () => cartData.increment(),
                                          child: AddButtonWidget(),
                                        ),
                                        SizedBox(
                                          width: SizeUtils.horizontalBlockSize *
                                              1.27,
                                        ),
                                        InkWell(
                                          onTap: () => cartData.decrement(),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: AppConst.green),
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              color: AppConst.green,
                                              size: SizeUtils
                                                      .horizontalBlockSize *
                                                  6,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeUtils.horizontalBlockSize *
                                              1.27,
                                        ),
                                        Text(
                                          cartData.items.toString(),
                                          style: AppStyles.BOLD_STYLE_GREEN,
                                        ),
                                      ],
                                    )),
                            ),
                          ]),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                SizeUtils.horizontalBlockSize * 3.8),
                            image: DecorationImage(
                                image: NetworkImage(product.image!),
                                fit: BoxFit.fill),
                            gradient: RadialGradient(
                              colors: [
                                AppConst.white,
                                AppConst.veryLightGrey,
                              ],
                              radius: 1,
                            ),
                          ),
                        ),
                        Text(
                          " \u20b9 ${storesWithProductsModel.amount.toString()}",
                          style: AppStyles.STORE_NAME_STYLE,
                        ),
                        Text(
                          storesWithProductsModel.itemName.toString(),
                          style: AppStyles.STORE_NAME_STYLE,
                        ),
                        Text(
                          storesWithProductsModel.quantity.toString(),
                          style: AppStyles.STORE_NAME_STYLE,
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: SizeUtils.horizontalBlockSize * 2.55,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              width: SizeUtils.horizontalBlockSize * 2.55,
            ),
          ],
        ),
        Divider(
          thickness: SizeUtils.horizontalBlockSize - 1.92,
        )
      ],
    );
  }
}
