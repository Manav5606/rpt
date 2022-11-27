import 'package:bubble/bubble.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/store/controller/store_controller.dart';
import 'package:customer_app/screens/store/screens/widget/store_search_item.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/search_text_field/search_field.dart';
import 'package:customer_app/widgets/search_text_field/search_field_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NewStoreChatScreen extends GetView<StoreController> {
  // const NewStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: AppConst.grey,
                      width: 1,
                    ),
                  )),
                  child: Stack(alignment: Alignment.topLeft, children: [
                    InkWell(
                        onTap: () => Get.back(), child: Icon(Icons.arrow_back)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Chat Orders",
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
                              style:
                                  AppTextStyle.h6Regular(color: AppConst.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
                SizedBox(height: 18),

                SearchField(
                  hintText: "Search for Items",
                  style: SearchFieldStyle.fromTheme(),
                  onChanged: (String text) => controller.search(text),
                ),

                SizedBox(height: 16),

                Obx(
                  () => Column(
                      children: controller.searchDisplayList
                          .map((element) => StoreSearchItem(product: element))
                          .toList()),
                )
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
            )),
    );
  }
}
