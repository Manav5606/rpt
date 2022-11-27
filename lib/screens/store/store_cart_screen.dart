import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/search/models/GetStoreDataModel.dart';
import 'package:customer_app/app/utils/app_constants.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/assets_constants.dart';
import 'package:customer_app/screens/store/store_controller.dart';
import 'package:customer_app/screens/store/widget/store_cart_item.dart';
import 'package:customer_app/screens/store/widget/store_search_item.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/search_text_field/search_field.dart';
import 'package:customer_app/widgets/search_text_field/search_field_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewStoreCartScreen extends GetView<StoreController> {
  // const NewStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: AppConst.grey,
                  width: 1,
                ),
              )),
              child: Stack(alignment: Alignment.topLeft, children: [
                InkWell(onTap: () => Get.back(), child: Icon(Icons.arrow_back)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Review Cart",
                          style: TextStyle(
                            fontSize: SizeUtils.horizontalBlockSize * 4,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'MuseoSans-700.otf',
                          ),
                          // AppStyles.STORE_NAME_STYLE,
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Vijetha Super Market",
                          style: AppTextStyle.h6Regular(color: AppConst.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppConst.containerGreenBackground,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Grow your Savings",
                      style: AppTextStyle.h35Bold(color: AppConst.darkGreen),
                    ),
                    SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: "Get ",
                        style:
                            AppTextStyle.h6Regular(color: AppConst.darkGreen),
                        children: [
                          TextSpan(
                            text: "₹10 Cashback ",
                            style: AppTextStyle.h6Medium(
                                color: AppConst.darkGreen),
                          ),
                          TextSpan(
                            text: "on orders above ₹399",
                            style: AppTextStyle.h6Regular(
                                color: AppConst.darkGreen),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    StoreCartItem(
                        product: StoreModelProducts(
                            cashback: 2,
                            name: 'dsdsd',
                            quntity: 2.obs,
                            logo: AssetsContants.placeholder,
                            sId: '22',
                            isQunitityAdd: true.obs)),
                    StoreCartItem(
                        product: StoreModelProducts(
                            cashback: 2,
                            name: 'dsdsd',
                            quntity: 2.obs,
                            logo: AssetsContants.placeholder,
                            sId: '22',
                            isQunitityAdd: true.obs)),
                    StoreCartItem(
                        product: StoreModelProducts(
                            cashback: 2,
                            name: 'dsdsd',
                            quntity: 2.obs,
                            logo: AssetsContants.placeholder,
                            sId: '22',
                            isQunitityAdd: true.obs)),
                    Spacer(),
                    Container(
                      // height: 36,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppConst.darkGreen,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Text(
                        "Goto Checkout",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.h4Bold(color: AppConst.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            // Obx(
            //   () => Column(
            //       children: controller.searchDisplayList
            //           .map((element) => StoreSearchItem(product: element))
            //           .toList()),
            // )
            // Text(
            //   "Catalog 1",
            //   style: TextStyle(
            //     fontSize: SizeUtils.horizontalBlockSize * 4,
            //     fontWeight: FontWeight.w700,
            //     fontFamily: 'MuseoSans-700.otf',
            //   ),
            //   // AppStyles.STORE_NAME_STYLE,
            // ),
            // SizedBox(height: 18),
            // SizedBox(
            //   height: 360,
            //   child: GridView.builder(
            //     physics: NeverScrollableScrollPhysics(),
            //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 2,
            //           crossAxisSpacing: Dimens.paddingXS,
            //           mainAxisSpacing: Dimens.paddingS,
            //         ),
            //         primary: false,
            //         // padding: const EdgeInsets.all(Dimens.paddingXS),
            //         itemCount: 4,
            //         itemBuilder: (context, index) => item(),
            //       ),
            // ),
            // SizedBox(height: 16),
          ],
        )),
      ),
    );
  }
}
