import 'dart:developer';

import 'package:customer_app/routes/app_list.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/home/models/GetAllCartsModel.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class YourStores extends StatelessWidget {
  final ScrollController? controller;

  YourStores({Key? key, this.controller}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Divider(
      //   thickness: 2.w,
      // ),
      // SizedBox(
      //   height: 2.h,
      // ),
      (_homeController.getAllCartsModel.value?.carts?.isNotEmpty ?? false)
          ? Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: Text(
                "Your stores",
                style: TextStyle(
                  fontSize: SizeUtils.horizontalBlockSize * 4.8,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'MuseoSans-700.otf',
                ),
              ),
            )
          : SizedBox(),
      SizedBox(
        height: 1.5.h,
      ),
      TextButton(
          onPressed: () {
            Get.toNamed(AppRoutes.NewStoreScreen,
                arguments: {'isGrocery': false});
          },
          child: Text("new store")),
      Container(
        height: 16.5.h,
        width: 98.w,
        // color: Colors.red,
        child: ListView.builder(
          padding: EdgeInsets.all(4),
          scrollDirection: Axis.horizontal,
          itemCount: _homeController.getAllCartsModel.value?.carts?.length ?? 0,
          itemBuilder: (context, index) {
            return Container(
              width: 96.w,
              height: 16.5.h,
              margin: EdgeInsets.only(
                right: 2.w,
              ),
              child: ListViewChild(
                yourStores:
                    _homeController.getAllCartsModel.value!.carts![index],
              ),
            );
          },
        ),
      ),
    ]);
  }
}

class ListViewChild extends StatelessWidget {
  final Carts yourStores;

  ListViewChild({Key? key, required this.yourStores}) : super(key: key);
  final ExploreController _exploreController = Get.find();
  final MoreStoreController _moreStoreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 2.h),
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
          vertical: 1.5.h,
        ),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(SizeUtils.horizontalBlockSize * 3.82),
          color: AppConst.white,
          // border: Border.all(color: AppConst.darkGrey, width: 0.1),
          boxShadow: [
            BoxShadow(
              color: AppConst.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 6,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: InkWell(
          onTap: () async {
            _exploreController.cartIndex.value = yourStores;
            _moreStoreController.storeId.value = yourStores.store?.sId ?? '';
            await _moreStoreController.getStoreData(
                id: yourStores.store?.sId ?? '',
                businessId: yourStores.store?.businesstype ?? '');
            _exploreController.totalItemCount.value =
                _exploreController.cartIndex.value?.totalItemsCount?.value ?? 0;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (yourStores.store?.logo != null)
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 0.h, left: 1.w),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppConst.grey)),
                        child: ClipOval(
                          child: ClipRRect(
                            child: CircleAvatar(
                              child: Text(
                                  yourStores.store?.name?.substring(0, 1) ?? "",
                                  style: TextStyle(
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 6)),
                              backgroundColor: AppConst.kPrimaryColor,
                              radius: SizeUtils.horizontalBlockSize * 6.5,
                            ),
                          ),
                        ),
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage:
                          NetworkImage(yourStores.store?.logo ?? ''),
                      backgroundColor: AppConst.white,
                      radius: SizeUtils.horizontalBlockSize * 6.5,
                    ),

              // CircleAvatar(
              //   backgroundImage: NetworkImage(yourStores.store?.logo ??
              //       'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
              //   backgroundColor: AppConst.white,
              //    radius: SizeUtils.horizontalBlockSize * 6.5,
              //   child: CachedNetworkImage(
              //     imageUrl: yourStores.store?.logo ??
              //         'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
              //     progressIndicatorBuilder: (context, url, downloadProgress) =>
              //         CircularProgressIndicator(
              //             value: downloadProgress.progress),
              //     errorWidget: (context, url, error) => Image.network(
              //         'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
              //   ),
              // ),
              SizedBox(
                width: 2.5.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      yourStores.store?.name ?? '',
                      style: TextStyle(
                        fontSize: SizeUtils.horizontalBlockSize * 4.5,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'MuseoSans-700.otf',
                      ),
                      // AppStyles.STORE_NAME_STYLE,
                    ),
                    if (yourStores.store?.storeType?.isNotEmpty ?? false)
                      if ((yourStores.store?.storeType ?? '') == 'online')
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                // StringContants.pickUp,
                                "Pickup /",
                                style:
                                    //  TextStyle(
                                    //   fontSize: SizeUtils.horizontalBlockSize * 4,
                                    //   fontWeight: FontWeight.w700,
                                    //   // color: AppConst.DarkColor,
                                    //   fontFamily: 'MuseoSans-700.otf',
                                    // ),
                                    AppStyles.BOLD_STYLE),
                            Text(
                              " Delivery",
                              style: AppStyles.BOLD_STYLE_GREEN,
                            ),
                          ],
                        )
                      else
                        Text(StringContants.pickUp,
                            style: AppStyles.BOLD_STYLE),
                    // Container(
                    //   margin: EdgeInsets.only(top: 1.h),
                    //   padding: EdgeInsets.all(1.w),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(4),
                    //     border:
                    //         Border.all(color: AppConst.darkGrey, width: 0.7),
                    //   ),
                    //   child: Text(
                    //       // "${inStoreModel?.calculateDistance?.toStringAsFixed(2)} 2.0 km away",
                    //       "2.0 km away",
                    //       style: TextStyle(
                    //           fontSize: SizeUtils.horizontalBlockSize * 3,
                    //           fontWeight: FontWeight.w500,
                    //           fontFamily: 'Stag',
                    //           color: AppConst.darkGrey,
                    //           letterSpacing: 0.5)),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
