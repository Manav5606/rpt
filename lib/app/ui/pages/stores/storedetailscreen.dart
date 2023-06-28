import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/data/models/category_model.dart';
import 'package:customer_app/widgets/instorelist.dart';
import 'package:customer_app/widgets/search_text_field/search_field_button.dart';
import 'package:customer_app/widgets/storesearchfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/stores/storeswithproductslist.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/widgets/cartWidget.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class StoreListScreen extends StatefulWidget {
  final CategoryModel? category;
  StoreListScreen({
    Key? key,
    this.category,
  }) : super(key: key);
  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late ScrollController _productScrollController;
  late AnimationController _hideFabAnimationController;
  final HomeController _homeController = Get.find();
  final AddCartController _addCartController = Get.find();
  bool last = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _productScrollController = ScrollController();
    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        case ScrollDirection.forward:
          _hideFabAnimationController.forward();
          break;
        case ScrollDirection.reverse:
          _hideFabAnimationController.reverse();
          break;
        case ScrollDirection.idle:
          break;
      }
    });

    _productScrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    setState(() {
      if (_productScrollController.position.pixels > 200) {
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
    // _hideFabAnimationController.dispose();
    _productScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var category = widget.category;
    return Scaffold(
      backgroundColor: AppConst.white,
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // var category =
          //     _homeController.getHomePageFavoriteShopsModel.value!.keywords!;
          return <Widget>[
            SliverAppBar(
              expandedHeight: 11.h,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: AppConst.white,
                  statusBarIconBrightness: Brightness.dark),
              centerTitle: true,
              pinned: true,
              stretch: true,
              floating: true,
              elevation: 0.5,
              scrolledUnderElevation: 0.5,
              // automaticallyImplyLeading: false,
              backgroundColor: AppConst.white, //Color(0xffaeebff),
              title: (innerBoxIsScrolled)
                  ? Row(
                      children: [
                        Container(
                          width: 65.w,
                          child: Text(
                            "${category?.title.toString() ?? ""}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'MuseoSans',
                                fontStyle: FontStyle.normal,
                                fontSize:
                                    (SizerUtil.deviceType == DeviceType.tablet)
                                        ? 11.sp
                                        : 12.5.sp,
                                color: AppConst.black),
                          ),
                        ),
                        Icon(
                          Icons.search,
                          size: 3.h,
                          color: AppConst.grey,
                        )
                      ],
                    )
                  : Row(
                      children: [
                        Container(
                          width: 70.w,
                          child: Text(
                            "${category?.title.toString() ?? ""}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'MuseoSans',
                                fontStyle: FontStyle.normal,
                                fontSize:
                                    (SizerUtil.deviceType == DeviceType.tablet)
                                        ? 11.sp
                                        : 12.5.sp,
                                color: AppConst.black),
                          ),
                        ),
                      ],
                    ),

              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 5.w),
                    //   child: Text(
                    //     // "Fresh Store near you",

                    //     "${category?.title.toString() ?? ""}",
                    //     overflow: TextOverflow.ellipsis,
                    //     maxLines: 1,
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w700,
                    //         fontFamily: 'MuseoSans',
                    //         fontStyle: FontStyle.normal,
                    //         fontSize:
                    //             (SizerUtil.deviceType == DeviceType.tablet)
                    //                 ? 11.sp
                    //                 : 12.5.sp,
                    //         color: AppConst.black),
                    //   ),
                    // ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 10.w, right: 10.w, bottom: 1.h),
                      child: StoreSearchField(),
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          // controller: _scrollController,

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => (_homeController.isRemoteConfigPageLoading1.value)
                    ? Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          InstoreListViewChildShimmer(),
                          ProductShimmerEffect(),
                          InstoreListViewChildShimmer(),
                          ProductShimmerEffect(),
                          InstoreListViewChildShimmer(),
                          ProductShimmerEffect(),
                        ],
                      )
                    : (_homeController.storeDataList.isEmpty)
                        ? Center(
                            child: Text(StringContants.noData),
                          )
                        : Container(
                            child: ListView.separated(
                              shrinkWrap: true,
                              controller: _scrollController,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: _homeController.storeDataList.length,
                              //data.length,
                              itemBuilder: (context, index) {
                                return ListViewStoreWithProduct(
                                  controller: _productScrollController,
                                  storesWithProductsModel:
                                      _homeController.storeDataList[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox();
                              },
                            ),
                          ),
              ),
              SizedBox(
                height: 60.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackButtonCircle extends StatelessWidget {
  const BackButtonCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 10,
          child: CircleAvatar(
            radius: 2.2.h,
            backgroundColor: AppConst.white,
            child: GestureDetector(
              // color: Colors.white,
              onTap: (() => Get.back()),
              child: Icon(
                Icons.arrow_back_rounded,
                size: SizeUtils.horizontalBlockSize * 7,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}
