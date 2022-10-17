import 'dart:developer';
import 'dart:io';

import 'package:customer_app/widgets/imagePicker.dart';
import 'package:flutter/material.dart';
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

  ChatOrderScreen({Key? key, this.isNewStore = false}) : super(key: key);

  @override
  State<ChatOrderScreen> createState() => _ChatOrderScreenState();
}

class _ChatOrderScreenState extends State<ChatOrderScreen> {
  final ChatOrderController _chatOrderController = Get.put(ChatOrderController());

  final AddCartController _addCartController = Get.find();

  @override
  void initState() {
    _chatOrderController.setValue(widget.isNewStore);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            // leading: Padding(
            //   padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 1.8),
            //   child: GestureDetector(
            //     onTap: () async {
            //       Get.back();
            //     },
            //     child: Icon(
            //       Icons.arrow_back,
            //       color: AppConst.black,
            //       size: SizeUtils.horizontalBlockSize * 7.65,
            //     ),
            //   ),
            // ),
            actions: [
              Obx(
                () {
                  return CartWidget(
                    onTap: () async {
                      Get.toNamed(
                        AppRoutes.CartReviewScreen,
                        arguments: {
                          'logo': _chatOrderController.cartIndex.value?.store?.logo,
                          'storeName': _chatOrderController.cartIndex.value?.store?.name,
                          'totalCount': _chatOrderController.cartIndex.value?.totalItemsCount?.value.toString()
                        },
                      );
                      await _addCartController.getReviewCartData(cartId: _chatOrderController.cartIndex.value?.sId ?? "");
                      // await _addCartController.getCartPageInformation(storeId: _chatOrderController.cartIndex.value?.store?.sId ?? "");
                      await _addCartController.getCartLocation(
                          storeId: _chatOrderController.cartIndex.value?.store?.sId ?? "", cartId: _chatOrderController.cartIndex.value?.sId ?? "");
                      _addCartController.store.value = _chatOrderController.cartIndex.value?.store;
                      _addCartController.cartId.value = _chatOrderController.cartIndex.value?.sId ?? "";
                    },
                    count: '${_chatOrderController.cartIndex.value?.totalItemsCount?.value}',
                  );
                },
              ),
            ],
            title: Column(
              children: [
                (_chatOrderController.cartIndex.value?.store?.logo != null)
                    ? Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppConst.grey)),
                        child: ClipOval(
                          child: ClipRRect(
                            child: CircleAvatar(
                              child: Text(_chatOrderController.cartIndex.value?.store?.name?.substring(0, 1) ?? "",
                                  style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 2)),
                              backgroundColor: AppConst.kPrimaryColor,
                              radius: SizeUtils.horizontalBlockSize * 2.5,
                            ),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(_chatOrderController.cartIndex.value?.store?.logo ?? ''),
                        backgroundColor: AppConst.white,
                        radius: SizeUtils.horizontalBlockSize * 2.5,
                      ),
                Text(
                  _chatOrderController.cartIndex.value?.store?.name ?? '',
                  style: TextStyle(
                    color: AppConst.black,
                    fontSize: SizeUtils.horizontalBlockSize * 4,
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () => ListView.builder(
                            itemCount: _chatOrderController.cartIndex.value?.rawItems?.length ?? 0,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(
                                          _chatOrderController.cartIndex.value?.rawItems?[index].logo ??
                                              'https://www.denofgeek.com/wp-content/uploads/2019/02/mcu-1-iron-man.jpg',
                                          height: 40,
                                          width: 40,
                                        ),
                                        SizedBox(
                                          width: SizeUtils.horizontalBlockSize * 1,
                                        ),
                                        Expanded(child: Text(_chatOrderController.cartIndex.value?.rawItems?[index].item ?? '')),
                                        Obx(
                                          () {
                                            return CustomPopMenu(
                                              title: 'Quantity',
                                              child: Container(
                                                decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: AppConst.grey)),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "${_chatOrderController.cartIndex.value?.rawItems?[index].quantity?.value ?? 0}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: AppStyles.BOLD_STYLE,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onSelected: (value) async {
                                                _chatOrderController.cartIndex.value?.rawItems?[index].quantity?.value = value;
                                                RawItems rawItems = RawItems(
                                                    item: _chatOrderController.cartIndex.value?.rawItems?[index].item ?? '',
                                                    quantity: _chatOrderController.cartIndex.value?.rawItems?[index].quantity,
                                                    unit: _chatOrderController.cartIndex.value?.rawItems?[index].unit ?? '');
                                                await _chatOrderController.addToCart(
                                                    newValueItem: _chatOrderController.cartIndex.value?.rawItems?[index].item ?? '',
                                                    cartId: _chatOrderController.cartIndex.value?.sId ?? '',
                                                    rawItem: rawItems,
                                                    isEdit: true);
                                              },
                                              list: _chatOrderController.quntityList,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    Text(_chatOrderController.cartIndex.value?.rawItems?[index].unit ?? ''),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _chatOrderController.itemController.text =
                                                _chatOrderController.cartIndex.value?.rawItems?[index].item ?? '';
                                            _chatOrderController.oldItem.value = _chatOrderController.cartIndex.value?.rawItems?[index].item ?? '';
                                            _chatOrderController.oldQuntity.value =
                                                _chatOrderController.cartIndex.value?.rawItems?[index].quantity?.value ?? 0;

                                            _chatOrderController.isEdit.value = true;
                                          },
                                          child: Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.edit,
                                                size: SizeUtils.horizontalBlockSize * 4,
                                                color: AppConst.green,
                                              ),
                                              SizedBox(
                                                width: SizeUtils.horizontalBlockSize * 4,
                                              ),
                                              Text(
                                                "Edit",
                                                style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 4, fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            RawItems rawItems = RawItems(
                                                item: _chatOrderController.cartIndex.value?.rawItems?[index].item ?? '',
                                                quantity: 0.obs,
                                                unit: _chatOrderController.cartIndex.value?.rawItems?[index].unit ?? '');
                                            _chatOrderController.addToCart(
                                                cartId: _chatOrderController.cartIndex.value?.sId ?? '',
                                                rawItem: rawItems,
                                                isEdit: false,
                                                newValueItem: '');
                                            _chatOrderController.cartIndex.refresh();
                                          },
                                          child: Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.trash,
                                                size: SizeUtils.horizontalBlockSize * 4,
                                                color: AppConst.green,
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Text(
                                                "Remove",
                                                style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 4, fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              _enterItem()
            ],
          ),
        ),
        Obx(() {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _chatOrderController.setValue(widget.isNewStore);
          });

          return _addCartController.onTabChange.value ? SizedBox.shrink() : SizedBox.shrink();
        })
      ],
    );
  }

//bottom textformfield and add button
  Widget _enterItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 3),
      child: Row(
        children: [
          Obx(
            () => (_chatOrderController.imagePath.value.isNotEmpty)
                ? Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.file(
                        File(_chatOrderController.imagePath.value),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
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
                      Icons.camera_enhance_rounded,
                      size: 26,
                    ),
                  ),
          ),
          Expanded(
            child: TextFormField(
              controller: _chatOrderController.itemController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 5),
              onChanged: (value) {},
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: AppConst.grey)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${_chatOrderController.unitList[_chatOrderController.selectUnitIndex.value]}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.BOLD_STYLE,
                    ),
                  ),
                ),
              ),
              onSelected: (value) async {
                _chatOrderController.selectUnitIndex.value = value;
              },
              list: _chatOrderController.unitList,
              isQunitity: false,
            ),
          ),
          GestureDetector(
            onTap: () async {
              log("_chatOrderController.file:${_chatOrderController.file}");
              if (_chatOrderController.file != null) {
                _chatOrderController.logo.value = await ImageHelper.uploadImage(_chatOrderController.file!);
              }
              log("_chatOrderController.logo.value:${_chatOrderController.logo.value}");
              RawItems rawItems = RawItems(
                item: _chatOrderController.isEdit.value ? _chatOrderController.oldItem.value : _chatOrderController.itemController.text,
                quantity: _chatOrderController.isEdit.value ? _chatOrderController.oldQuntity : 1.obs,
                unit: _chatOrderController.unitList[_chatOrderController.selectUnitIndex.value],
                logo: _chatOrderController.logo.value,
              );
              await _chatOrderController.addToCart(
                  newValueItem: _chatOrderController.itemController.text,
                  cartId: _chatOrderController.cartIndex.value?.sId ?? '',
                  rawItem: rawItems,
                  isEdit: _chatOrderController.isEdit.value);
              _chatOrderController.imagePath.value = '';
              _chatOrderController.file = null;
              _chatOrderController.isEdit.value = false;
              _chatOrderController.itemController.clear();
              _chatOrderController.oldItem.isEmpty;
            },
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h), child: Icon(Icons.send)),
          ),
        ],
      ),
    );
  }
}
