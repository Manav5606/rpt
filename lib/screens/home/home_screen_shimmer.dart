import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/provider/firebase/firebase_notification.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/stores/InStoreScreen.dart';
import 'package:customer_app/app/ui/pages/stores/storedetailscreen.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/data/models/category_model.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/screens/more_stores/all_offers.dart';
import 'package:customer_app/widgets/cartWidget.dart';
import 'package:customer_app/widgets/category_card.dart';
import 'package:customer_app/widgets/yourStores.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreenShimmer extends StatefulWidget {
  const HomeScreenShimmer({Key? key}) : super(key: key);

  @override
  _HomeScreenShimmerState createState() => _HomeScreenShimmerState();
}

class _HomeScreenShimmerState extends State<HomeScreenShimmer>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late ScrollController _categoryController;

  late AnimationController _hideFabAnimController;

  late double percent;
  int currentItems = 4;
  bool last = false;
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    percent = .50;
    _scrollController = ScrollController();
    _categoryController = ScrollController();
    _hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1,
    );

    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        case ScrollDirection.forward:
          _hideFabAnimController.forward();
          break;
        case ScrollDirection.reverse:
          _hideFabAnimController.reverse();
          break;
        case ScrollDirection.idle:
          break;
      }
    });

    _categoryController.addListener(_scrollListener);

    // Notification
    FireBaseNotification().localNotificationRequestPermissions();
    FireBaseNotification().configureDidReceiveLocalNotificationSubject();
    FireBaseNotification().configureSelectNotificationSubject();
  }

  _scrollListener() {
    setState(() {
      if (_categoryController.position.pixels > 200) {
        setState(() {
          last = true;
        });
      } else {
        setState(() {
          last = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _hideFabAnimController.dispose();
    FireBaseNotification().localNotificationDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 2.h, left: 1.w, right: 1.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerEffect(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppConst.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppConst.grey.withOpacity(0.5),
                          spreadRadius: -3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: AppConst.kPrimaryColor,
                                size: SizeUtils.horizontalBlockSize * 7,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          _homeController
                                              .userAddressTitle.value,
                                          style: AppStyles.ADDRESS_STYLE,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          size: 6.w,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 70.w,
                                      child: Text(
                                        _homeController.userAddress.value,
                                        style: AppStyles.ADDRESS_STYLE,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ShimmerEffect(
                          child: CartWidget(
                            onTap: () async {},
                            count: _homeController
                                    .getAllCartsModel.value?.cartItemsTotal
                                    .toString() ??
                                "",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ShimmerEffect(
                  child: SizedBox(
                    height: 2.h,
                  ),
                ),
                Expanded(
                  child: ShimmerEffect(
                    child: ListView(
                      controller:
                          _homeController.homePageFavoriteShopsScrollController,
                      children: [
                        Container(
                          height: 12.h,
                          width: double.infinity,
                          child: ListView.builder(
                            controller: _categoryController,
                            itemCount: _homeController
                                    .getHomePageFavoriteShopsModel
                                    .value
                                    ?.keywords
                                    ?.length ??
                                0,
                            physics: PageScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemExtent: SizeUtils.horizontalBlockSize * 20,
                            itemBuilder: (context, index) {
                              //currentItems = index;
                              return GestureDetector(
                                  onTap: () async {
                                    _homeController.storeDataList.clear();
                                    _homeController.remoteConfigPageNumber = 1;
                                    _homeController
                                        .isRemoteConfigPageAvailable = true;
                                    _homeController.keywordValue =
                                        CategoryModel(
                                      isProductAvailable: _homeController
                                              .getHomePageFavoriteShopsModel
                                              .value
                                              ?.keywords?[index]
                                              .isProductAvailable ??
                                          false,
                                      id: _homeController
                                          .getHomePageFavoriteShopsModel
                                          .value!
                                          .keywords![index]
                                          .id,
                                      keywordHelper: _homeController
                                          .getHomePageFavoriteShopsModel
                                          .value!
                                          .keywords![index]
                                          .keywordHelper,
                                      name: _homeController
                                          .getHomePageFavoriteShopsModel
                                          .value!
                                          .keywords![index]
                                          .name,
                                      subtitle: '',
                                      image: '',
                                      title: '',
                                    );
                                    await _homeController
                                        .homePageRemoteConfigData(
                                      productFetch: _homeController
                                              .getHomePageFavoriteShopsModel
                                              .value
                                              ?.keywords?[index]
                                              .isProductAvailable ??
                                          false,
                                      keyword: _homeController
                                          .getHomePageFavoriteShopsModel
                                          .value!
                                          .keywords![index]
                                          .name,
                                      keywordHelper: _homeController
                                          .getHomePageFavoriteShopsModel
                                          .value!
                                          .keywords![index]
                                          .keywordHelper,
                                      id: _homeController
                                          .getHomePageFavoriteShopsModel
                                          .value!
                                          .keywords![index]
                                          .id,
                                    );

                                    (!(_homeController
                                                .getHomePageFavoriteShopsModel
                                                .value
                                                ?.keywords?[index]
                                                .isProductAvailable ??
                                            false))
                                        ? Get.to(() => InStoreScreen())
                                        : Get.to(() => StoreListScreen());
                                  },
                                  child: CategoryCard(
                                      index: index,
                                      category: _homeController
                                          .getHomePageFavoriteShopsModel
                                          .value!
                                          .keywords![index]));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        YourStores(),
                        SizedBox(
                          height: 2.h,
                        ),
                        Divider(
                          thickness: 2.w,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        AllOffers(),
                        SizedBox(
                          height: 2.h,
                        ),
                        AllOffersListView(
                          controller: _scrollController,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.h),
                          child: Container(
                            width: double.infinity,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                StringContants.receipto,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25.sp,
                                  letterSpacing: 1,
                                  color: AppConst.grey,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: FadeTransition(
        //   opacity: _hideFabAnimController,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       // SizedBox(
        //       //   height: 50,
        //       //   width: 50,
        //       //   child: FloatingActionButton(
        //       //     heroTag: '1',
        //       //     elevation: 1,
        //       //     onPressed: () {
        //       //       Get.to(() => LocationPickerScreen());
        //       //     },
        //       //     backgroundColor: kSecondaryColor,
        //       //   child: SvgPicture.asset(AssetsContants.cartLogo,
        //       //       color: Colors.white, semanticsLabel: 'Acme Logo'),
        //       // ),
        //       // ),
        //       FloatingActionButton(
        //         heroTag: '2',
        //         elevation: 1,
        //         backgroundColor: AppConst.kPrimaryColor,
        //         onPressed: () {},
        //         child: Icon(Icons.camera_alt_outlined),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
