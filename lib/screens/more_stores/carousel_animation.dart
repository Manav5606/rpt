import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/home/models/homeFavStoreModel.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CarouselAnimation extends StatelessWidget {
  int index;
  int count;
  final HomeFavModel? inStoreModel;
  CarouselAnimation(
      {Key? key, required this.index, this.inStoreModel, required this.count})
      : super(key: key);

  final MoreStoreController _moreStoreController = Get.find();
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _moreStoreController.storeId.value = inStoreModel?.id ?? '';
        await _moreStoreController.getStoreData(
            id: inStoreModel?.id ?? '',
            businessId: inStoreModel?.businesstype ?? '');
      },
      child: Container(
        height: 20.h,
        width: double.infinity,
        // color: AppConst.yellow,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
              ),
              child: Container(
                height: 16.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // color: AppConst.lightGreen,
                  // border: Border.all(color: Colors.grey[500]),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff1C8AE2),
                      Color(0xff1F6AC2),
                      Color(0xff265CC0),
                      Color(0xff254BB5),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 7.w, top: 2.h, right: 3.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Container(
                                  // width: 20.w,
                                  decoration: BoxDecoration(
                                      color: AppConst.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 1.h),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.workspace_premium_outlined,
                                          color: Color(0xff1C8AE2),
                                          size: 1.6.h,
                                        ),
                                        SizedBox(
                                          width: 0.5.w,
                                        ),
                                        Text("${inStoreModel?.name ?? ''}",
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'MuseoSans',
                                              color: Colors.black,
                                              fontSize: (SizerUtil.deviceType ==
                                                      DeviceType.tablet)
                                                  ? 8.sp
                                                  : 9.sp,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${inStoreModel?.defaultCashback}",
                                    style: TextStyle(
                                      fontFamily: 'MuseoSans',
                                      color: AppConst.white,
                                      fontSize: (SizerUtil.deviceType ==
                                              DeviceType.tablet)
                                          ? 25.sp
                                          : 30.sp,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  Text(
                                    "%",
                                    style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: AppConst.white,
                                        fontSize: (SizerUtil.deviceType ==
                                                DeviceType.tablet)
                                            ? 15.sp
                                            : 18.sp,
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: -1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 0.5.h),
                                    child: Text(
                                      " OFF",
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: AppConst.white,
                                        fontSize: (SizerUtil.deviceType ==
                                                DeviceType.tablet)
                                            ? 13.sp
                                            : 15.sp,
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 1.h),
                                child: Text(
                                  "for your each order",
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: AppConst.white,
                                    fontSize: (SizerUtil.deviceType ==
                                            DeviceType.tablet)
                                        ? 7.5.sp
                                        : 8.5.sp,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 1.h, right: 3.w),
                          child: DispalyStoreLogo(
                            logo: inStoreModel?.logo,
                            bottomPadding: 0,
                            height: 14,
                            BusinessType: inStoreModel?.businesstype,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 1.h),
            // // Obx(() =>

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: _buildIndicator(index),
            // )
            // )
          ],
        ),
        // ),
      ),
    );
  }

  List<Widget> _buildIndicator(int currentIndex) {
    List<Widget> indicators = [];
    for (int i = 0; i < count; i++) {
      indicators.add(Container(
        width: 8,
        height: 8,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == i ? AppConst.green : Colors.grey[400]),
      ));
    }
    return indicators;
  }
}
