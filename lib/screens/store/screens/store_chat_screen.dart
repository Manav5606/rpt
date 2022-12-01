import 'dart:io';

import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/search/models/GetStoreDataModel.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder_controller.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/assets_constants.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/store/controller/store_controller.dart';
import 'package:customer_app/screens/store/screens/widget/store_cart_item.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/custom_popupmenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NewStoreChatScreen extends GetView<StoreController> {
  // const NewStoreScreen({super.key});
  final ChatOrderController _chatOrderController =
      Get.put(ChatOrderController());

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: AppConst.green,
                      ),
                      SizedBox(width: 20),
                      Text(
                        controller.totalItemsCount.toString() + " Item",
                        style: AppTextStyle.h4Regular(color: AppConst.black),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () => Get.toNamed(AppRoutes.NewStoreCartScreen),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          // height: 5.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(85),
                            color: AppConst.green,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "View Cart",
                                style:
                                    AppTextStyle.h5Bold(color: AppConst.white),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                                color: AppConst.white,
                              ),
                            ],
                          ),
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
                  child: SingleChildScrollView(
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
                        StoreCartItem(
                            product: StoreModelProducts(
                                cashback: 2,
                                name: 'dsdsd',
                                quntity: 2.obs,
                                logo: AssetsContants.placeholder,
                                sId: '22',
                                isQunitityAdd: true.obs)),
                        // Spacer(),
                        // _enterItem(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        resizeToAvoidBottomInset: false,
        floatingActionButton: _enterItem());
  }

//bottom textformfield and add button
  Widget _enterItem() {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeUtils.horizontalBlockSize * 3,
          right: SizeUtils.horizontalBlockSize * 3,
          bottom: 8),
      child: Row(
        children: [
          Obx(
            () => (_chatOrderController.imagePath.value.isNotEmpty)
                ? Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(_chatOrderController.imagePath.value),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: GestureDetector(
                          onTap: () {
                            _chatOrderController.imagePath.value = '';
                            _chatOrderController.file = null;
                          },
                          child: Icon(
                            Icons.close,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  )
                : GestureDetector(
                    onTap: () {
                      _chatOrderController.imagePicker();
                    },
                    child: Icon(
                      Icons.camera_alt,
                      color: AppConst.darkGreen,
                      size: 26,
                    ),
                  ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: AppConst.grey)),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _chatOrderController.itemController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 5),
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // contentPadding:
                        //     const EdgeInsets.symmetric(horizontal: 12.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        hintText: 'say something',
                      ),
                    ),
                  ),
                  Obx(
                    () => CustomPopMenu(
                      title: 'Unit',
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppConst.darkGreen,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${_chatOrderController.unitList[_chatOrderController.selectUnitIndex.value]}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    AppTextStyle.h6Bold(color: AppConst.white),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: AppConst.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      onSelected: (value) async {
                        // _chatOrderController.selectUnitIndex.value = value;
                      },
                      list: _chatOrderController.unitList,
                      isQunitity: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              // log("_chatOrderController.file:${_chatOrderController.file}");
              // if (_chatOrderController.file != null) {
              //   _chatOrderController.logo.value =
              //       await ImageHelper.uploadImage(_chatOrderController.file!);
              // }
              // log("_chatOrderController.logo.value:${_chatOrderController.logo.value}");
              // RawItems rawItems = RawItems(
              //   item: _chatOrderController.isEdit.value
              //       ? _chatOrderController.oldItem.value
              //       : _chatOrderController.itemController.text,
              //   quantity: _chatOrderController.isEdit.value
              //       ? _chatOrderController.oldQuntity
              //       : 1.obs,
              //   unit: _chatOrderController
              //       .unitList[_chatOrderController.selectUnitIndex.value],
              //   logo: _chatOrderController.logo.value,
              // );
              // await _chatOrderController.addToCart(
              //     newValueItem: _chatOrderController.itemController.text,
              //     cartId: _chatOrderController.cartIndex.value?.sId ?? '',
              //     rawItem: rawItems,
              //     isEdit: _chatOrderController.isEdit.value);
              // _chatOrderController.imagePath.value = '';
              // _chatOrderController.file = null;
              // _chatOrderController.isEdit.value = false;
              // _chatOrderController.itemController.clear();
              // _chatOrderController.oldItem.isEmpty;
            },
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Icon(Icons.send, color: AppConst.green)),
          ),
        ],
      ),
    );
  }
}
