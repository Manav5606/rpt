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
        title: Text(
          '',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppConst.black),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.rtl,
                  controller: _paymentController.searchController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      suffixIcon: (_paymentController.searchText.value.isEmpty)
                          ? Icon(
                              Icons.search,
                              size: SizeUtils.horizontalBlockSize * 6,
                              color: AppConst.black,
                            )
                          : IconButton(
                              onPressed: () {
                                _paymentController.searchController.clear();
                                _paymentController.searchText.value = '';
                                _paymentController
                                    .getNearMePageDataModel.value?.data?.stores
                                    ?.clear();
                                Get.back();
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: AppConst.black,
                                size: SizeUtils.horizontalBlockSize * 6,
                              )),
                      counterText: "",
                      isDense: true,
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
                  onChanged: (value) {
                    _paymentController.searchText.value = value;
                    _paymentController.searchText.value.isNotEmpty
                        ? _paymentController.getNearMePageData(
                            searchText: value)
                        : _paymentController.getNearMePageData(searchText: " ");
                    // onSearch(value);
                  }),
              SizedBox(
                height: SizeUtils.horizontalBlockSize * 5,
              ),
              Obx(
                () => (((_paymentController.getNearMePageDataModel.value?.data
                            ?.stores?.isEmpty ??
                        true)))
                    ? _paymentController.searchText.value.isNotEmpty
                        ? Center(
                            child: Text(
                              'No Results found !',
                              style: AppStyles.STORE_NAME_STYLE,
                            ),
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
                height: 2.h,
              ),
              Obx(
                () => (((_paymentController.getNearMePageDataModel.value?.data
                            ?.stores?.isEmpty ??
                        true)))
                    ? _paymentController.searchText.value.isNotEmpty
                        ? SizedBox()
                        : Expanded(
                            child: SingleChildScrollView(
                              child: RecentSearchList(
                                foundedStores: _paymentController
                                    .scanRecentProductList.value,
                                isScanFunction: true,
                              ),
                            ),
                          )
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
