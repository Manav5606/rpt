import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/store/controller/store_controller.dart';
import 'package:customer_app/screens/store/screens/widget/chat_bubble.dart';
import 'package:customer_app/screens/store/screens/widget/store_product_list.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/search_text_field/search_field_button.dart';
import 'package:customer_app/widgets/search_text_field/search_field_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewStoreScreen extends GetView<StoreController> {
  // const NewStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    InkWell(
                        onTap: () => Get.back(), child: Icon(Icons.arrow_back)),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Vijetha Super Market",
                  style: TextStyle(
                    fontSize: SizeUtils.horizontalBlockSize * 4,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'MuseoSans-700.otf',
                  ),
                  // AppStyles.STORE_NAME_STYLE,
                ),
                SizedBox(height: 2),
                Text(
                  "Kukatpally",
                  style: AppTextStyle.h6Regular(color: AppConst.grey),
                ),
                SizedBox(height: 12),

                StoreChatBubble(
                    buttonText: "Chat",
                    text:
                        "Struggling to find items? \nChat with store & place orders instantly.",
                    onTap: () => Get.toNamed(AppRoutes.NewStoreChatScreen)),
                SizedBox(height: 16),

                SearchFieldButton(
                    onTab: () => Get.toNamed(AppRoutes.NewStoreSearchScreen),
                    style: SearchFieldStyle.fromTheme()),
                // Obx(() => Text("${controller.totalItemsCount}")),

                SizedBox(height: 16),
                Obx(() => (!controller.isLoadingStoreData.value)
                    ? StoreProductList()
                    : SizedBox())
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() => controller.totalItemsCount == 0
          ? SizedBox()
          : Container(
              // color: Color.fromARGB(114, 255, 193, 7),
              margin: EdgeInsets.only(bottom: 0),
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: AppConst.green,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: AppConst.white,
                  ),
                  SizedBox(width: 4),
                  Text(
                    controller.totalItemsCount.toString() + " Item",
                    style: AppTextStyle.h4Regular(color: AppConst.white),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () => Get.toNamed(AppRoutes.NewStoreCartScreen),
                    child: Row(
                      children: [
                        Text(
                          "View Cart",
                          style: AppTextStyle.h4Regular(color: AppConst.white),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppConst.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
    );
  }
}
