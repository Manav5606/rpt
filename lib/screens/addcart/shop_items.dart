import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:get/get.dart';

class ShopItemsScreen extends StatelessWidget {
  final OrderData order;

  const ShopItemsScreen({Key? key, required this.order}) : super(key: key);

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
              height: SizeUtils.verticalBlockSize * 1,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: order.products?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.horizontalBlockSize * 4),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          height: SizeUtils.horizontalBlockSize * 12,
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
                        width: SizeUtils.horizontalBlockSize * 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            order.products?[index].name ?? '',
                            style: TextStyle(
                              color: AppConst.grey,
                              fontSize: SizeUtils.horizontalBlockSize * 5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1,
                          ),
                          Text(
                            '${order.products?[index].quantity ?? ''}',
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
                        '${order.products?[index].sellingPrice ?? ''}',
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
              itemCount: order.rawItems?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.horizontalBlockSize * 4),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          height: SizeUtils.horizontalBlockSize * 12,
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
                        width: SizeUtils.horizontalBlockSize * 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            order.rawItems?[index].item ?? '',
                            style: TextStyle(
                              color: AppConst.grey,
                              fontSize: SizeUtils.horizontalBlockSize * 5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1,
                          ),
                          Text(
                            '${order.rawItems?[index].quantity ?? ''}',
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
                        '${order.rawItems?[index].quantity ?? ''}',
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
