import 'dart:developer';
import 'dart:io';

import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/widgets/imagePicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder_controller.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/cartWidget.dart';
import 'package:customer_app/widgets/custom_popupmenu.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../screens/home/models/GetAllCartsModel.dart';

class ChatOrderScreen extends StatefulWidget {
  final bool isNewStore;
  String? businessID = "";

  ChatOrderScreen({Key? key, this.isNewStore = false, this.businessID})
      : super(key: key);

  @override
  State<ChatOrderScreen> createState() => _ChatOrderScreenState();
}

class _ChatOrderScreenState extends State<ChatOrderScreen> {
  final ChatOrderController chatOrderController =
      Get.put(ChatOrderController());

  final AddCartController _addCartController = Get.find();

  @override
  void initState() {
    chatOrderController.setValue(widget.isNewStore);
    Map arg = Get.arguments ?? {};

    chatOrderController.itemController.text = arg['text'] ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Chat Order",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: AppConst.black,
                    fontSize: SizeUtils.horizontalBlockSize * 4.5,
                  ),
                ),
                Text(
                  chatOrderController.cartIndex.value?.store?.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: AppConst.grey,
                    fontSize: SizeUtils.horizontalBlockSize * 3.7,
                  ),
                ),
              ],
            ),
          ),
          body: Obx((() => (chatOrderController.isLoading.value == true)
              ? ChatShimmerView(chatOrderController: chatOrderController)
              : Column(
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Obx(
                      () => GestureDetector(
                          onTap: (chatOrderController.cartIndex.value
                                      ?.totalItemsCount?.value !=
                                  0)
                              ? () async {
                                  Get.toNamed(
                                    AppRoutes.CartReviewScreen,
                                    arguments: {
                                      'logo': chatOrderController
                                          .cartIndex.value?.store?.logo,
                                      'storeName': chatOrderController
                                          .cartIndex.value?.store?.name,
                                      'totalCount': chatOrderController
                                          .cartIndex
                                          .value
                                          ?.totalItemsCount
                                          ?.value
                                          .toString(),
                                      'id': chatOrderController
                                          .cartIndex.value?.store?.sId,
                                      "businessID": widget.businessID
                                    },
                                  );
                                  await _addCartController.getReviewCartData(
                                      cartId: chatOrderController
                                              .cartIndex.value?.sId ??
                                          "");
                                  // await _addCartController.getCartPageInformation(storeId: chatOrderController.cartIndex.value?.store?.sId ?? "");
                                  await _addCartController.getCartLocation(
                                      storeId: chatOrderController
                                              .cartIndex.value?.store?.sId ??
                                          "",
                                      cartId: chatOrderController
                                              .cartIndex.value?.sId ??
                                          "");
                                  _addCartController.store.value =
                                      chatOrderController
                                          .cartIndex.value?.store;
                                  _addCartController.cartId.value =
                                      chatOrderController
                                              .cartIndex.value?.sId ??
                                          "";
                                }
                              : null,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 1.5.h),
                            decoration: BoxDecoration(color: Color(0xffe6faf1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Item Count : ${chatOrderController.cartIndex.value?.totalItemsCount?.value ?? 0}",
                                        style: TextStyle(
                                          fontFamily: 'MuseoSans',
                                          color: AppConst.darkGreen,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  4.5,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        )),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text("Tap here to view the Cart",
                                        style: TextStyle(
                                          fontFamily: 'MuseoSans',
                                          color: AppConst.darkGreen,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  3.2,
                                          fontWeight: FontWeight.w300,
                                          fontStyle: FontStyle.normal,
                                        ))
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 2.5.h,
                                  color: AppConst.darkGreen,
                                )
                              ],
                            ),
                          )

                          // Padding(
                          //   padding: EdgeInsets.only(left: 4.w, right: 3.w),
                          //   child: Row(
                          //     children: [
                          //       Icon(
                          //         Icons.shopping_cart,
                          //         color: AppConst.green,
                          //       ),
                          //       SizedBox(
                          //         width: 3.w,
                          //       ),
                          //       Text(
                          //           "${chatOrderController.cartIndex.value?.totalItemsCount?.value ?? 0} Item",
                          //           style: TextStyle(
                          //             fontFamily: 'MuseoSans',
                          //             color: AppConst.black,
                          //             fontSize: SizeUtils.horizontalBlockSize * 4,
                          //             fontWeight: FontWeight.w500,
                          //             fontStyle: FontStyle.normal,
                          //           )),
                          //       Spacer(),
                          //       Text(
                          //           (chatOrderController.cartIndex.value
                          //                       ?.totalItemsCount?.value !=
                          //                   0)
                          //               ? "View Cart"
                          //               : "",
                          //           style: TextStyle(
                          //             fontFamily: 'MuseoSans',
                          //             color: AppConst.green,
                          //             fontSize: SizeUtils.horizontalBlockSize * 3.7,
                          //             fontWeight: FontWeight.w600,
                          //             fontStyle: FontStyle.normal,
                          //           )),
                          //       (chatOrderController
                          //                   .cartIndex.value?.totalItemsCount?.value !=
                          //               0)
                          //           ? Icon(
                          //               Icons.arrow_forward_ios_outlined,
                          //               color: AppConst.green,
                          //               size: 2.2.h,
                          //             )
                          //           : SizedBox(),
                          //     ],
                          //   ),
                          // ),
                          ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Obx(
                            //   () => GestureDetector(
                            //     onTap: () async {
                            //       Get.toNamed(
                            //         AppRoutes.CartReviewScreen,
                            //         arguments: {
                            //           'logo': chatOrderController
                            //               .cartIndex.value?.store?.logo,
                            //           'storeName': chatOrderController
                            //               .cartIndex.value?.store?.name,
                            //           'totalCount': chatOrderController
                            //               .cartIndex.value?.totalItemsCount?.value
                            //               .toString()
                            //         },
                            //       );
                            //       await _addCartController.getReviewCartData(
                            //           cartId:
                            //               chatOrderController.cartIndex.value?.sId ??
                            //                   "");
                            //       // await _addCartController.getCartPageInformation(storeId: chatOrderController.cartIndex.value?.store?.sId ?? "");
                            //       await _addCartController.getCartLocation(
                            //           storeId: chatOrderController
                            //                   .cartIndex.value?.store?.sId ??
                            //               "",
                            //           cartId:
                            //               chatOrderController.cartIndex.value?.sId ??
                            //                   "");
                            //       _addCartController.store.value =
                            //           chatOrderController.cartIndex.value?.store;
                            //       _addCartController.cartId.value =
                            //           chatOrderController.cartIndex.value?.sId ?? "";
                            //     },
                            //     child: Padding(
                            //       padding: EdgeInsets.only(left: 4.w, right: 2.w),
                            //       child: Row(
                            //         children: [
                            //           Icon(
                            //             Icons.shopping_cart,
                            //             color: AppConst.green,
                            //           ),
                            //           SizedBox(
                            //             width: 3.w,
                            //           ),
                            //           Text(
                            //               "${chatOrderController.cartIndex.value?.totalItemsCount?.value ?? 0} Item",
                            //               style: TextStyle(
                            //                 fontFamily: 'MuseoSans',
                            //                 color: AppConst.black,
                            //                 fontSize:
                            //                     SizeUtils.horizontalBlockSize * 4,
                            //                 fontWeight: FontWeight.w500,
                            //                 fontStyle: FontStyle.normal,
                            //               )),
                            //           Spacer(),
                            //           Text("View Cart",
                            //               style: TextStyle(
                            //                 fontFamily: 'MuseoSans',
                            //                 color: AppConst.green,
                            //                 fontSize:
                            //                     SizeUtils.horizontalBlockSize * 3.7,
                            //                 fontWeight: FontWeight.w600,
                            //                 fontStyle: FontStyle.normal,
                            //               )),
                            //           Icon(
                            //             Icons.arrow_forward_ios_outlined,
                            //             color: AppConst.green,
                            //             size: 2.2.h,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 6.w, top: 2.h, bottom: 1.h),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 1.5.h),
                                    child: Icon(
                                      Icons.info,
                                      size: 2.4.h,
                                      color: AppConst.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text(
                                      "Incase the product is not available in the shop,\n the Store will contact you.",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: AppConst.grey,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      ))
                                ],
                              ),
                            ),
                            Obx(
                              () => ListView.builder(
                                  itemCount: chatOrderController
                                          .cartIndex.value?.rawItems?.length ??
                                      0,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (context, index) {
                                    return StoreChatRawItem(
                                        index: index,
                                        chatOrderController:
                                            chatOrderController);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _enterItem()
                  ],
                ))),
        ),
        Obx(() {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            chatOrderController.setValue(widget.isNewStore);
          });

          return _addCartController.onTabChange.value
              ? SizedBox.shrink()
              : SizedBox.shrink();
        })
      ],
    );
  }

//bottom textformfield and add button
  Widget _enterItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(
            () => (chatOrderController.imagePath.value.isNotEmpty ||
                    (chatOrderController.Oldlogo.value != null &&
                        chatOrderController.Oldlogo.value != ""))
                ? Stack(
                    alignment: Alignment.topRight,
                    children: [
                      (chatOrderController.Oldlogo.value != null &&
                              chatOrderController.Oldlogo.value != "")
                          ? DisplayProductImage(
                              logo: chatOrderController.Oldlogo.value,
                              height: 8.h,
                              width: 16.w,
                            )
                          : Image.file(
                              File(chatOrderController.imagePath.value),
                              height: 8.h,
                              width: 16.w,
                              fit: BoxFit.cover,
                            ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: GestureDetector(
                          onTap: () {
                            if ((chatOrderController.Oldlogo.value != null &&
                                chatOrderController.Oldlogo.value != "")) {
                              chatOrderController.Oldlogo.value = "";
                            }
                            chatOrderController.imagePath.value = '';
                            chatOrderController.file = null;
                          },
                          child: Icon(
                            Icons.close,
                            size: 2.2.h,
                          ),
                        ),
                      ),
                    ],
                  )
                : GestureDetector(
                    onTap: () {
                      chatOrderController.imagePicker();
                    },
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: AppConst.darkGreen,
                      size: 4.h,
                    ),
                  ),
          ),
          SizedBox(
            width: 1.w,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppConst.grey),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Obx(
                  () => SizedBox(
                    width: (chatOrderController.imagePath.value.isNotEmpty ||
                            (chatOrderController.Oldlogo.value != null &&
                                chatOrderController.Oldlogo.value != ""))
                        ? 49.w
                        : 62.w,
                    child: TextFormField(
                      inputFormatters: [
                        NoLeadingSpaceFormatter(),
                      ],
                      controller: chatOrderController.itemController,
                      keyboardType: TextInputType.multiline,
                      cursorColor: AppConst.black,
                      maxLines: null,
                      style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 4),
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        hintText: 'Type your Order Here',
                      ),
                    ),
                  ),
                ),
                Obx(
                  () {
                    return CustomPopMenu(
                      title: 'Quantity',
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppConst.darkGreen,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppConst.darkGreen)),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 1.w, top: 0.7.h, bottom: 0.7.h),
                            child: Row(
                              children: [
                                Text(
                                    (chatOrderController.isEdit.value &&
                                            !chatOrderController
                                                .isQuantityUpdated.value)
                                        ? "Qt.${chatOrderController.oldQuntity.value}"
                                        : (chatOrderController
                                                .isQuantityUpdated.value)
                                            ? "Qt.${chatOrderController.quntity.value}"
                                            : "Qt.1",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'MuseoSans',
                                      color: AppConst.white,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    )),
                                Icon(
                                  Icons.arrow_drop_down_sharp,
                                  color: AppConst.white,
                                  size: 2.5.h,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      onSelected: (value) async {
                        if (chatOrderController.itemController.text != null &&
                            chatOrderController.itemController.text != "") {
                          chatOrderController.isQuantityUpdated.value = true;
                          chatOrderController.quntity.value = value;
                        }
                      },
                      list: chatOrderController.quntityList,
                    );
                  },
                ),
                // Obx(
                //   () => CustomPopMenu(
                //     title: 'Select Unit',
                //     child: Container(
                //       decoration: BoxDecoration(
                //           color: AppConst.darkGreen,
                //           borderRadius: BorderRadius.circular(4),
                //           border: Border.all(color: AppConst.darkGreen)),
                //       child: Center(
                //         child: Padding(
                //           padding: EdgeInsets.only(
                //               left: 1.w, top: 0.7.h, bottom: 0.7.h),
                //           child: Row(
                //             children: [
                //               Text(
                //                   "${chatOrderController.unitList[chatOrderController.selectUnitIndex.value]}",
                //                   maxLines: 1,
                //                   overflow: TextOverflow.ellipsis,
                //                   style: TextStyle(
                //                     fontFamily: 'MuseoSans',
                //                     color: AppConst.white,
                //                     fontSize: SizeUtils.horizontalBlockSize * 4,
                //                     fontWeight: FontWeight.w500,
                //                     fontStyle: FontStyle.normal,
                //                   )),
                //               Icon(
                //                 Icons.arrow_drop_down_sharp,
                //                 color: AppConst.white,
                //                 size: 2.5.h,
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //     onSelected: (value) async {
                //       chatOrderController.selectUnitIndex.value = value;
                //     },
                //     list: chatOrderController.unitList,
                //     isQunitity: false,
                //   ),
                // ),
                SizedBox(
                  width: 2.w,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              chatOrderController.isLoading.value = true;
              log("chatOrderController.file:${chatOrderController.file}");
              if (chatOrderController.file != null) {
                chatOrderController.logo.value =
                    await ImageHelper.uploadImage(chatOrderController.file!);
              }
              log("chatOrderController.logo.value:${chatOrderController.logo.value}");
              if (chatOrderController.itemController.text != null &&
                  chatOrderController.itemController.text != "") {
                RawItems rawItems = RawItems(
                    item: chatOrderController.isEdit.value
                        ? chatOrderController.oldItem.value
                        : chatOrderController.itemController.text,
                    quantity: (chatOrderController.isEdit.value &&
                            !chatOrderController.isQuantityUpdated.value)
                        ? chatOrderController.oldQuntity
                        : (chatOrderController.isQuantityUpdated.value)
                            ? chatOrderController.quntity
                            : 1.obs,
                    unit: chatOrderController
                        .unitList[chatOrderController.selectUnitIndex.value],
                    logo: (chatOrderController.file != null)
                        ? chatOrderController.logo.value
                        : chatOrderController.Oldlogo.value,
                    sId: chatOrderController.IsEditId.value);
                await chatOrderController.addToCart(
                    newValueItem: chatOrderController.itemController.text,
                    cartId: chatOrderController.cartIndex.value?.sId ?? '',
                    store_id:
                        chatOrderController.cartIndex.value?.store?.sId ?? "",
                    rawItem: rawItems,
                    isEdit: chatOrderController.isEdit.value);
                chatOrderController.imagePath.value = '';
                chatOrderController.logo.value = "";
                chatOrderController.file = null;
                chatOrderController.isEdit.value = false;
                chatOrderController.isQuantityUpdated.value = false;
                chatOrderController.quntity.value = 0;
                chatOrderController.itemController.clear();
                chatOrderController.oldItem.isEmpty;
                chatOrderController.IsEditId.value = "";
                chatOrderController.Oldlogo.value = "";
              }
              chatOrderController.isLoading.value = false;
              // else {
              //   Get.snackbar("", "",
              //       titleText: Text("Please Enter your order details",
              //           style: TextStyle(
              //             fontFamily: 'MuseoSans',
              //             color: AppConst.black,
              //             fontSize: SizeUtils.horizontalBlockSize * 3.7,
              //             fontWeight: FontWeight.w500,
              //             fontStyle: FontStyle.normal,
              //           )),
              //       snackPosition: SnackPosition.BOTTOM,
              //       duration: Duration(seconds: 1));
              // }
            },
            child: Padding(
                padding: EdgeInsets.only(left: 2.w, top: 1.h, bottom: 1.h),
                child: Icon(
                  Icons.send,
                  color: AppConst.green,
                  size: 3.h,
                )),
          ),
        ],
      ),
    );
  }
}

class ChatShimmerView extends StatelessWidget {
  const ChatShimmerView({
    Key? key,
    required this.chatOrderController,
  }) : super(key: key);

  final ChatOrderController chatOrderController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 1.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
          decoration: BoxDecoration(color: AppConst.veryLightGrey),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerEffect(
                    child: Container(
                      height: 2.7.h,
                      width: 40.w,
                      color: AppConst.black,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  ShimmerEffect(
                    child: Container(
                      height: 2.4.h,
                      width: 60.w,
                      color: AppConst.black,
                    ),
                  ),
                ],
              ),
              ShimmerEffect(
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 2.5.h,
                  color: AppConst.darkGreen,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 6.w, top: 2.h, bottom: 1.h),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.5.h),
                        child: ShimmerEffect(
                          child: Icon(
                            Icons.info,
                            size: 2.4.h,
                            color: AppConst.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      ShimmerEffect(
                        child: Text(
                            "Incase the product is not available in the shop,\n the Store will contact you.",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'MuseoSans',
                              color: AppConst.grey,
                              fontSize: SizeUtils.horizontalBlockSize * 3,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            )),
                      )
                    ],
                  ),
                ),
                Obx(
                  () => ListView.builder(
                      itemCount: chatOrderController
                              .cartIndex.value?.rawItems?.length ??
                          0,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return ShimmerEffect(
                          child: StoreChatRawItem(
                              index: index,
                              chatOrderController: chatOrderController),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
        //  _enterItem()
      ],
    );
  }
}

class StoreChatRawItem extends StatelessWidget {
  StoreChatRawItem(
      {Key? key, required this.chatOrderController, required this.index})
      : super(key: key);

  final ChatOrderController chatOrderController;
  int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppConst.lightGrey),
            borderRadius: BorderRadiusDirectional.circular(12),
            color: Color(0xffeceaff)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                chatOrderController.itemController.text = chatOrderController
                        .cartIndex.value?.rawItems?[index].item ??
                    '';
                chatOrderController.oldItem.value = chatOrderController
                        .cartIndex.value?.rawItems?[index].item ??
                    '';
                chatOrderController.oldQuntity.value = chatOrderController
                        .cartIndex.value?.rawItems?[index].quantity?.value ??
                    0;
                chatOrderController.Oldlogo.value = chatOrderController
                        .cartIndex.value?.rawItems?[index].logo ??
                    '';
                chatOrderController.IsEditId.value =
                    chatOrderController.cartIndex.value?.rawItems?[index].sId ??
                        "";
                chatOrderController.isEdit.value = true;
              },
              child: Row(
                children: [
                  (chatOrderController.cartIndex.value?.rawItems?[index].logo !=
                              null &&
                          chatOrderController
                                  .cartIndex.value?.rawItems?[index].logo !=
                              "")
                      ? DisplayProductImage(
                          logo: chatOrderController
                              .cartIndex.value?.rawItems?[index].logo,
                          height: 12.h,
                          width: 24.w,
                        )
                      : SizedBox(),
                  (chatOrderController.cartIndex.value?.rawItems?[index].logo !=
                              null &&
                          chatOrderController
                                  .cartIndex.value?.rawItems?[index].logo !=
                              "")
                      ? SizedBox(width: 3.w)
                      : SizedBox(),
                  SizedBox(
                    width: (chatOrderController
                                    .cartIndex.value?.rawItems?[index].logo !=
                                null &&
                            chatOrderController
                                    .cartIndex.value?.rawItems?[index].logo !=
                                "")
                        ? 60.w
                        : 85.w,
                    child: Text(
                        "${chatOrderController.cartIndex.value?.rawItems?[index].item}",
                        style: TextStyle(
                          fontFamily: 'MuseoSans',
                          color: AppConst.black,
                          fontSize: SizeUtils.horizontalBlockSize * 4,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                  // Spacer(),
                  // Padding(
                  //   padding: EdgeInsets.only(bottom: 3.h),
                  //   child: Obx(
                  //     () {
                  //       return CustomPopMenu(
                  //         title: 'Quantity',
                  //         child: DisplayProductCount(
                  //           count: chatOrderController.cartIndex.value
                  //               ?.rawItems?[index].quantity?.value,
                  //         ),
                  //         onSelected: (value) async {
                  //           chatOrderController.cartIndex.value?.rawItems?[index]
                  //               .quantity?.value = value;
                  //           RawItems rawItems = RawItems(
                  //             item: chatOrderController
                  //                     .cartIndex.value?.rawItems?[index].item ??
                  //                 '',
                  //             quantity: chatOrderController
                  //                 .cartIndex.value?.rawItems?[index].quantity,
                  //             unit: chatOrderController
                  //                     .cartIndex.value?.rawItems?[index].unit ??
                  //                 '',
                  //             sId: chatOrderController
                  //                     .cartIndex.value?.rawItems?[index].sId ??
                  //                 '',
                  //             logo: chatOrderController
                  //                     .cartIndex.value?.rawItems?[index].logo ??
                  //                 '',
                  //           );
                  //           var isID = chatOrderController
                  //               .cartIndex.value?.rawItems?[index].sId;

                  //           await chatOrderController.addToCart(
                  //               newValueItem: chatOrderController
                  //                       .cartIndex.value?.rawItems?[index].item ??
                  //                   '',
                  //               cartId:
                  //                   chatOrderController.cartIndex.value?.sId ??
                  //                       '',
                  //               rawItem: rawItems,
                  //               store_id: chatOrderController
                  //                       .cartIndex.value?.store?.sId ??
                  //                   "",
                  //               isEdit:
                  //                   isID != null && isID != "" ? true : false);
                  //         },
                  //         list: chatOrderController.quntityList,
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () {
                      return CustomPopMenu(
                        title: 'Quantity',
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Quantity: ",
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: AppConst.black,
                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              )),
                          TextSpan(
                              text:
                                  "${chatOrderController.cartIndex.value?.rawItems?[index].quantity?.value}",
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: AppConst.black,
                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              )),
                        ])),
                        onSelected: (value) async {
                          chatOrderController.cartIndex.value?.rawItems?[index]
                              .quantity?.value = value;
                          RawItems rawItems = RawItems(
                            item: chatOrderController
                                    .cartIndex.value?.rawItems?[index].item ??
                                '',
                            quantity: chatOrderController
                                .cartIndex.value?.rawItems?[index].quantity,
                            unit: chatOrderController
                                    .cartIndex.value?.rawItems?[index].unit ??
                                '',
                            sId: chatOrderController
                                    .cartIndex.value?.rawItems?[index].sId ??
                                '',
                            logo: chatOrderController
                                    .cartIndex.value?.rawItems?[index].logo ??
                                '',
                          );
                          var isID = chatOrderController
                              .cartIndex.value?.rawItems?[index].sId;

                          await chatOrderController.addToCart(
                              newValueItem: chatOrderController
                                      .cartIndex.value?.rawItems?[index].item ??
                                  '',
                              cartId:
                                  chatOrderController.cartIndex.value?.sId ??
                                      '',
                              rawItem: rawItems,
                              store_id: chatOrderController
                                      .cartIndex.value?.store?.sId ??
                                  "",
                              isEdit:
                                  isID != null && isID != "" ? true : false);
                        },
                        list: chatOrderController.quntityList,
                      );
                    },
                  ),
                  Text(" (Tap to edit the order)",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.grey,
                        fontSize: SizeUtils.horizontalBlockSize * 3.5,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ))
                ],
              ),
            )
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            // GestureDetector(
            //   onTap: () {
            //     chatOrderController.itemController.text =
            //         chatOrderController
            //                 .cartIndex.value?.rawItems?[index].item ??
            //             '';
            //     chatOrderController.oldItem.value = chatOrderController
            //             .cartIndex.value?.rawItems?[index].item ??
            //         '';
            //     chatOrderController.oldQuntity.value = chatOrderController
            //             .cartIndex
            //             .value
            //             ?.rawItems?[index]
            //             .quantity
            //             ?.value ??
            //         0;

            //     chatOrderController.isEdit.value = true;
            //   },
            //   child: Row(
            //     children: [
            //       FaIcon(
            //         FontAwesomeIcons.edit,
            //         size: SizeUtils.horizontalBlockSize * 4,
            //         color: AppConst.green,
            //       ),
            //       SizedBox(
            //         width: SizeUtils.horizontalBlockSize * 4,
            //       ),
            //       Text(
            //         "Edit",
            //         style: TextStyle(
            //             fontSize: SizeUtils.horizontalBlockSize * 4,
            //             fontWeight: FontWeight.w500),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   width: 3.w,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     RawItems rawItems = RawItems(
            //         item: chatOrderController
            //                 .cartIndex.value?.rawItems?[index].item ??
            //             '',
            //         quantity: 0.obs,
            //         unit: chatOrderController
            //                 .cartIndex.value?.rawItems?[index].unit ??
            //             '');
            //     chatOrderController.addToCart(
            //         cartId: chatOrderController.cartIndex.value?.sId ?? '',
            //         rawItem: rawItems,
            //         isEdit: false,
            //         newValueItem: '');
            //     chatOrderController.cartIndex.refresh();
            //   },
            //   child: Row(
            //     children: [
            //       FaIcon(
            //         FontAwesomeIcons.trash,
            //         size: SizeUtils.horizontalBlockSize * 4,
            //         color: AppConst.green,
            //       ),
            //       SizedBox(
            //         width: 3.w,
            //       ),
            //       Text(
            //         "Remove",
            //         style: TextStyle(
            //             fontSize: SizeUtils.horizontalBlockSize * 4,
            //             fontWeight: FontWeight.w500),
            //       ),
            //     ],
            //   ),
            // ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class DisplayProductCount extends StatelessWidget {
  DisplayProductCount({Key? key, this.count}) : super(key: key);

  int? count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.5.h,
      width: 18.w,
      decoration: BoxDecoration(
        color: AppConst.white,
        // border: Border.all(color: AppConst.grey, width: 0.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppConst.grey,
            blurRadius: 1,
            // offset: Offset(1, 1),
          ),
        ],
      ),
      child: Center(
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "-  ",
            style: TextStyle(
              fontFamily: 'MuseoSans',
              color: AppConst.green,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
          ),
          TextSpan(
            text: "${count ?? 0}",
            style: TextStyle(
              fontFamily: 'MuseoSans',
              color: AppConst.black,
              fontSize: SizeUtils.horizontalBlockSize * 3.8,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
          ),
          TextSpan(
            text: "  +",
            style: TextStyle(
              fontFamily: 'MuseoSans',
              color: AppConst.green,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
          )
        ])),
      ),
    );
  }
}

class DisplayProductName extends StatelessWidget {
  DisplayProductName({Key? key, this.name}) : super(key: key);

  String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55.w,
      // height: 4.8.h,
      // color: AppConst.red,
      child: Text(
          name
              // chatOrderController
              // .cartIndex.value?.rawItems?[index].item
              ??
              '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'MuseoSans',
            color: AppConst.black,
            fontSize: SizeUtils.horizontalBlockSize * 4,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          )),
    );
  }
}

class DisplayProductImage extends StatelessWidget {
  DisplayProductImage({Key? key, this.logo, this.height, this.width})
      : super(key: key);

  String? logo;
  var height;
  var width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 8.h,
      width: width ?? 16.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: (logo == null || logo == "")
          ? Image.asset("assets/images/noproducts.png")
          : ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                logo
                    // chatOrderController.cartIndex.value?.rawItems?[index].logo
                    ??
                    '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                      height: 8.h,
                      width: 16.w,
                      child: Image.asset("assets/images/noproducts.png"));
                },
              ),
            ),
    );
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}
