import 'dart:developer';

import 'package:customer_app/app/constants/colors.dart';
import 'package:customer_app/screens/wallet/loyaltyCardList.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/data/model/get_claim_rewards_model.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OfferCard extends StatefulWidget {
  final Stores stores;

  const OfferCard({required this.stores});

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  final AddLocationController _addLocationController = Get.find();

  @override
  Widget build(BuildContext context) {
    Color? color = randomGenerator();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   children: [
          //     (widget.stores.logo?.isNotEmpty ?? false)
          //         ? CircleAvatar(
          //             radius: SizeUtils.horizontalBlockSize * 8.92,
          //             backgroundColor: AppConst.white,
          //             foregroundImage: NetworkImage(
          //               widget.stores.logo ?? '',
          //             ),
          //           )
          //         : CircleAvatar(
          //             radius: SizeUtils.horizontalBlockSize * 8.92,
          //             backgroundColor: AppConst.white,
          //             foregroundImage: AssetImage(
          //               'assets/images/grocery.png',
          //             ),
          //           ),
          //     SizedBox(
          //       width: SizeUtils.horizontalBlockSize * 2.55,
          //     ),
          //     Flexible(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             widget.stores.name ?? '',
          //             maxLines: 1,
          //             overflow: TextOverflow.ellipsis,
          //             style: TextStyle(
          //                 fontSize: SizeUtils.horizontalBlockSize * 5.10,
          //                 fontWeight: FontWeight.bold),
          //           ),
          //           Text(
          //             "\u20b9${widget.stores.actualCashback ?? 0} cashback",
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: SizeUtils.horizontalBlockSize * 4.08,
          //             ),
          //           ),
          //           (widget.stores.calculatedDistance.toString().isEmpty)
          //               ? Text(
          //                   "0 KM",
          //                   style: TextStyle(
          //                     fontSize: SizeUtils.horizontalBlockSize * 4.08,
          //                   ),
          //                 )
          //               : Text(
          //                   "${(widget.stores.calculatedDistance! / 1000).toStringAsFixed(2)} KM",
          //                   style: TextStyle(
          //                     fontSize: SizeUtils.horizontalBlockSize * 4.08,
          //                   ),
          //                 ),

          //           (widget.stores.businesstype.toString() ==
          //                   "5fde415692cc6c13f9e879fd")
          //               ? Icon(Icons.local_grocery_store)
          //               : Icon(Icons.shopping_bag_rounded),
          //           // Container(
          //           //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //           //   margin: const EdgeInsets.only(top: 5),
          //           //   color: Colors.grey[200],
          //           //   child: Text("${widget.stores.calculatedDistance?.toStringAsFixed(2) ?? 0}",),
          //           // )
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          CardlistView(
              color: color,
              isDisplayDistance: true,
              StoreID: "${widget.stores.sId ?? ""}",
              StoreName: "${widget.stores.name ?? ""}",
              distanceOrOffer: widget.stores.distance ?? 0,
              Balance: widget.stores.actualCashback ?? 0),
          // widget.stores.flag == 'true'
//               ? Row(
//                 children: [
//                   Icon(Icons.done), SizedBox(width: 3.w,)
// , Text("Rejected",
//     style: TextStyle(
//     fontFamily: 'MuseoSans',
//     color: Color(0xff005b41),
//     fontSize: SizeUtils.horizontalBlockSize*3.7,
//     fontWeight: FontWeight.w700,
//     fontStyle: FontStyle.normal,

//     )
// )                ],
          // )
          widget.stores.flag == 'true'
              ? ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.stores.flag = 'false';
                      _addLocationController.updatedStoresCount.value =
                          _addLocationController.updatedStoresCount.value - 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    visualDensity: VisualDensity(horizontal: -4),
                    primary: AppConst.kSecondaryColor,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(0),
                  ),
                  child: Icon(Icons.done),
                )
              : OutlinedButton(
                  onPressed: () {
                    setState(() {
                      widget.stores.flag = 'true';
                      _addLocationController.updatedStoresCount.value =
                          _addLocationController.updatedStoresCount.value + 1;
                    });
                  },
                  child: Icon(
                    FontAwesomeIcons.plus,
                    color: AppConst.kPrimaryColor,
                  ),
                  style: OutlinedButton.styleFrom(
                    visualDensity: VisualDensity(horizontal: -4),
                    side: BorderSide(
                      width: SizeUtils.horizontalBlockSize * 0.25,
                      color: AppConst.kPrimaryColor,
                    ),
                    shape: CircleBorder(),
                    padding: EdgeInsets.only(
                        bottom: SizeUtils.horizontalBlockSize * 0.5),
                  ),
                ),
        ],
      ),
    );
  }
}
