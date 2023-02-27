import 'package:customer_app/data/models/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/stores/storeswithproductslist.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/widgets/cartWidget.dart';
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
  final HomeController _homeController = Get.find();
  final AddCartController _addCartController = Get.find();

  @override
  Widget build(BuildContext context) {
    var category = widget.category;
    return Scaffold(
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // var category =
          //     _homeController.getHomePageFavoriteShopsModel.value!.keywords!;
          return <Widget>[
            SliverAppBar(
              expandedHeight: 12.h,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color(0xffaeebff),
                  statusBarIconBrightness: Brightness.dark),
              centerTitle: true,
              pinned: true,
              stretch: true,
              floating: true,
              // automaticallyImplyLeading: false,
              backgroundColor: Color(0xffaeebff),
              title: (innerBoxIsScrolled)
                  ? Row(
                      children: [
                        Container(
                          width: 75.w,
                          child: Text(
                            "${category?.title.toString() ?? ""}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: AppConst.black,
                              fontFamily: 'MuseoSans',
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          "",
                          style: TextStyle(
                              color: AppConst.black,
                              fontSize: SizeUtils.horizontalBlockSize * 4),
                        ),
                      ],
                    ),

              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, left: 5.w),
                      child: Text(
                        // "Fresh Store near you",

                        "${category?.title.toString() ?? ""}",
                        // "Pickup",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MuseoSans',
                            fontStyle: FontStyle.normal,
                            fontSize: SizeUtils.horizontalBlockSize * 4.5,
                            color: AppConst.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          // controller: _homeController.remoteConfigScrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StoreWithProductsList(),
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
