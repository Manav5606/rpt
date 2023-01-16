import 'package:customer_app/screens/history/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/scanReceipt/search_peoduct.dart';
import 'package:customer_app/screens/wallet/controller/paymentController.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/recentSearchList.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SearchRecipeScreen extends StatelessWidget {
  final PaymentController _paymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Row(
            children: [
              SizedBox(
                width: 4.w,
              ),
              SizedBox(
                height: 3.5.h,
                child: Image(
                  image: AssetImage(
                    'assets/images/Scan.png',
                  ),
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text("Scan any Stores",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.black,
                    fontSize: SizeUtils.horizontalBlockSize * 4.5,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  )),
            ],
          )
          // Text(
          //   '',
          //   style: TextStyle(
          //       fontSize: 16.sp,
          //       fontWeight: FontWeight.bold,
          //       color: AppConst.black),
          // ),
          ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: Container(
                  decoration: BoxDecoration(color: AppConst.veryLightGrey),
                  child: TextField(
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.rtl,
                      controller: _paymentController.searchController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 3.w),
                          suffixIcon: (_paymentController
                                  .searchText.value.isEmpty)
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    _paymentController.searchController.clear();
                                    _paymentController.searchText.value = '';
                                    _paymentController.getNearMePageDataModel
                                        .value?.data?.stores
                                        ?.clear();
                                    // Get.back();
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: AppConst.grey,
                                    size: SizeUtils.horizontalBlockSize * 6,
                                  )),
                          prefixIcon:
                              (_paymentController.searchText.value.isEmpty)
                                  ? Icon(
                                      Icons.search,
                                      color: AppConst.grey,
                                      size: SizeUtils.horizontalBlockSize * 6,
                                    )
                                  : null,
                          counterText: "",
                          isDense: true,
                          border: InputBorder.none,
                          // OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(12),
                          //   borderSide:
                          //       BorderSide(width: 1, color: AppConst.transparent),
                          // ),
                          focusedBorder: InputBorder.none,
                          // OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(12),
                          //   borderSide: BorderSide(color: AppConst.black),
                          // ),
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
                      onChanged: (value) {
                        _paymentController.searchText.value = value;
                        _paymentController.searchText.value.isNotEmpty
                            ? _paymentController.getNearMePageData(
                                searchText: value)
                            : _paymentController.getNearMePageData(
                                searchText: " ");
                        // onSearch(value);
                      }),
                ),
              ),
              SizedBox(
                height: SizeUtils.horizontalBlockSize * 5,
              ),
              Obx(
                () => (((_paymentController.getNearMePageDataModel.value?.data
                            ?.stores?.isEmpty ??
                        true)))
                    ? _paymentController.searchText.value != null &&
                            _paymentController.searchText.value != ""
                        ? Center(
                            child: EmptyHistoryPage(
                                icon: Icons.shopping_cart,
                                text1: "Nothing Here !",
                                text2: "",
                                text3: "")

                            // Text(
                            //   'No Results found !',
                            //   style: AppStyles.STORE_NAME_STYLE,
                            // ),
                            )
                        : Text(
                            'Recently Searched',
                            style: AppStyles.STORE_NAME_STYLE,
                          )
                    : Text(
                        'Results',
                        style: AppStyles.STORE_NAME_STYLE,
                      ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Obx(
                () => (((_paymentController.getNearMePageDataModel.value?.data
                            ?.stores?.isEmpty ??
                        true)))
                    ? _paymentController.searchText.value != null &&
                            _paymentController.searchText.value != ""
                        ? SizedBox()
                        : Wrap(
                            children: _paymentController
                                .scanRecentProductList.value
                                .map(
                                  (e) => InkWell(
                                    onTap: () => {
                                      _paymentController.searchText.value =
                                          e.name ?? "",
                                      _paymentController.searchController.text =
                                          _paymentController.searchText.value,
                                      _paymentController.getNearMePageData(
                                          searchText: _paymentController
                                              .searchText.value),
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.w, vertical: 0.5.h),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 0.5.h),
                                        decoration: BoxDecoration(
                                            color: AppConst.lightGrey,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.access_time_rounded,
                                              color: AppConst.grey,
                                              size: 2.h,
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text(
                                              e.name ?? "",
                                              style: TextStyle(
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    3,
                                                fontFamily: 'MuseoSans',
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                color: AppConst.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toSet()
                                .toList(),
                          )

                    // Expanded(
                    //     child: SingleChildScrollView(
                    //       child: RecentSearchList(
                    //         foundedStores: _paymentController
                    //             .scanRecentProductList.value,
                    //         isScanFunction: true,
                    //       ),
                    //     ),
                    //   )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: SearchList(),
                        ),
                      ),
              )
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: SearchList(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
