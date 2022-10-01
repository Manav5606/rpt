import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/data/model/active_order_model.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ShopItemsScreen extends StatelessWidget {
  final OrderData? order;
  final ActiveOrderData? activeOrder;
  bool? allorder;

  ShopItemsScreen(
      {Key? key, this.order, this.activeOrder, this.allorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConst.transparent,
        elevation: 00,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppConst.green,
            size: SizeUtils.verticalBlockSize * 3,
          ),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'My Items',
              style: TextStyle(
                  color: AppConst.black,
                  fontSize: SizeUtils.horizontalBlockSize * 4,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Rainbow Grocery - Delivery @ 12 PM - 1 PM',
              style: TextStyle(
                  color: AppConst.grey,
                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.horizontalBlockSize * 4),
              child: Text(
                'Chat',
                style: TextStyle(
                    color: AppConst.green,
                    fontSize: SizeUtils.horizontalBlockSize * 5,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: SizeUtils.verticalBlockSize * 5,
              width: double.infinity,
              decoration: BoxDecoration(color: AppConst.grey.withOpacity(0.15)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: SizeUtils.horizontalBlockSize * 2,
                  ),
                  child: Text(
                    'Shopped',
                    style: TextStyle(
                        color: AppConst.grey.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeUtils.horizontalBlockSize * 5),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (allorder!)
                  ? (order?.products?.length ?? 0)
                  : (activeOrder?.products?.length ?? 0),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          width: 12.w,
                          height: 6.h,
                          fit: BoxFit.contain,
                          imageUrl:
                              'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress)),
                          errorWidget: (context, url, error) => Image.network(
                              'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 70.w,
                            child: Text(
                              (allorder!)
                                  ? (order?.products?[index].name ?? '')
                                  : (activeOrder?.products?[index].name ?? ''),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppConst.grey,
                                fontSize: SizeUtils.horizontalBlockSize * 4.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            (allorder!)
                                ? ('${order?.products?[index].quantity ?? ''}')
                                : ('${activeOrder?.products?[index].quantity ?? ''}'),
                            style: TextStyle(
                              color: AppConst.grey.withOpacity(0.6),
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        (allorder!)
                            ? ('${order?.products?[index].sellingPrice ?? ''}')
                            : ('${activeOrder?.products?[index].sellingPrice ?? ''}'),
                        style: TextStyle(
                            color: AppConst.black.withOpacity(0.6),
                            fontWeight: FontWeight.w800,
                            fontSize: SizeUtils.horizontalBlockSize * 4),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: AppConst.grey.withOpacity(0.2),
                thickness: 2,
              ),
            ),
            Container(
              height: SizeUtils.verticalBlockSize * 5,
              width: double.infinity,
              decoration: BoxDecoration(color: AppConst.grey.withOpacity(0.15)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Raw Product',
                    style: TextStyle(
                        color: AppConst.grey.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeUtils.horizontalBlockSize * 5),
                  ),
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (allorder!)
                  ? (order?.rawItems?.length ?? 0)
                  : (activeOrder?.rawItems?.length ?? 0),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.horizontalBlockSize * 4),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          width: 12.w,
                          height: 6.h,
                          fit: BoxFit.contain,
                          imageUrl:
                              'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress)),
                          errorWidget: (context, url, error) => Image.network(
                              'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 70.w,
                            child: Text(
                              (allorder!)
                                  ? (order?.rawItems?[index].item ?? '')
                                  : (activeOrder?.rawItems?[index].item ?? ''),
                              style: TextStyle(
                                color: AppConst.grey,
                                fontSize: SizeUtils.horizontalBlockSize * 4.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            (allorder!)
                                ? ('${order?.rawItems?[index].quantity ?? ''}')
                                : ('${activeOrder?.rawItems?[index].quantity ?? ''}'),
                            style: TextStyle(
                              color: AppConst.grey.withOpacity(0.6),
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        (allorder!)
                            ? ('${order?.rawItems?[index].quantity ?? ''}')
                            : ('${activeOrder?.rawItems?[index].quantity ?? ''}'),
                        style: TextStyle(
                            color: AppConst.black.withOpacity(0.6),
                            fontWeight: FontWeight.w800,
                            fontSize: SizeUtils.horizontalBlockSize * 4),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: AppConst.grey.withOpacity(0.2),
                thickness: 2,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              height: SizeUtils.verticalBlockSize * 5,
              width: double.infinity,
              decoration: BoxDecoration(color: AppConst.grey.withOpacity(0.15)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Inventory',
                    style: TextStyle(
                        color: AppConst.grey.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeUtils.horizontalBlockSize * 5),
                  ),
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (allorder!)
                  ? (order?.inventories?.length ?? 0)
                  : (activeOrder?.inventories?.length ?? 0),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          width: 12.w,
                          height: 6.h,
                          fit: BoxFit.contain,
                          imageUrl:
                              'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress)),
                          errorWidget: (context, url, error) => Image.network(
                              'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 70.w,
                            child: Text(
                              (allorder!)
                                  ? (order?.inventories?[index].name ?? '')
                                  : (activeOrder?.inventories?[index].name ??
                                      ''),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppConst.grey,
                                fontSize: SizeUtils.horizontalBlockSize * 4.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            (allorder!)
                                ? ('${order?.inventories?[index].quantity ?? ''}')
                                : ('${activeOrder?.inventories?[index].quantity ?? ''}'),
                            style: TextStyle(
                              color: AppConst.grey.withOpacity(0.6),
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        (allorder!)
                            ? ('${order?.inventories?[index].sellingPrice ?? ''}')
                            : ('${activeOrder?.inventories?[index].sellingPrice ?? ''}'),
                        style: TextStyle(
                            color: AppConst.black.withOpacity(0.6),
                            fontWeight: FontWeight.w800,
                            fontSize: SizeUtils.horizontalBlockSize * 4),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: AppConst.grey.withOpacity(0.2),
                thickness: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
