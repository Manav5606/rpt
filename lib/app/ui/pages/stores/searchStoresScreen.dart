import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/app/ui/pages/stores/searchedStoresWihProducts.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SearchStoresScreen extends StatefulWidget {
  @override
  State<SearchStoresScreen> createState() => __SearchStoresScreenState();
}

class __SearchStoresScreenState extends State<SearchStoresScreen>
    with TickerProviderStateMixin {
  final ExploreController _exploreController = Get.find();

  @override
  Widget build(BuildContext context) {
    _exploreController.dummySearchController.text =
        _exploreController.searchText.value;
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: SizeUtils.horizontalBlockSize * 15,
              decoration: BoxDecoration(color: AppConst.white, boxShadow: []),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          useRootNavigator: true,
                          builder: (context) {
                            return AddressModel();
                          });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: AppConst.kPrimaryColor,
                          size: SizeUtils.horizontalBlockSize * 5.6,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          StringContants.orderScreenAddress,
                          style: AppStyles.ADDRESS_STYLE,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: SizeUtils.horizontalBlockSize * 6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              textAlign: TextAlign.left,
              textDirection: TextDirection.rtl,
              controller: _exploreController.dummySearchController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  suffixIcon: (_exploreController.searchText.value.isEmpty)
                      ? Icon(
                          Icons.search,
                          size: SizeUtils.horizontalBlockSize * 6,
                          color: AppConst.black,
                        )
                      : IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: AppConst.black,
                            size: SizeUtils.horizontalBlockSize * 6,
                          )),
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppConst.black),
                  ),
                  hintTextDirection: TextDirection.rtl,
                  hintText: " Search products,stores & recipes",
                  hintStyle: TextStyle(
                      color: AppConst.grey,
                      fontSize: SizeUtils.horizontalBlockSize * 4)),
              showCursor: true,
              cursorColor: AppConst.black,
              cursorHeight: SizeUtils.horizontalBlockSize * 5,
              maxLength: 30,
              style: TextStyle(
                color: AppConst.black,
                fontSize: SizeUtils.horizontalBlockSize * 4,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Center(
              child: Text(
                "Stores having products \"${_exploreController.searchText.value}\"",
                style: AppStyles.STORE_NAME_STYLE,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(child: SearchedStoreProductsList()),
            ),
          ],
        ),
      ),
    );
  }
}
