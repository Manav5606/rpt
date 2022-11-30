import 'package:customer_app/screens/addcart/Widgets/store_name_call_logo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/data/models/category_model.dart';
import 'package:sizer/sizer.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  int index;
  CategoryCard({Key? key, required this.category, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "assets/images/Fresh.png",
      "assets/images/groceryImage.png",
      "assets/images/Nonveg.png",
      "assets/images/Pickup.png",
      "assets/images/Premium.png",
      "assets/images/Medics.png",
      "assets/images/Pickup.png",
      "assets/images/Fresh.png"
    ];
    return Container(
      height: 20.h,
      width: 30.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image(
        image: AssetImage(images[index]
            // 'assets/images/Fresh.png',
            ),
        fit: BoxFit.fitWidth,
      ),
    );

    // Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Flexible(
    //       child: Container(
    //         height: 7.h,
    //         width: 15.w,
    //         decoration: BoxDecoration(
    //           //   borderRadius: BorderRadius.circular(10),
    //           shape: BoxShape.circle,
    //           color: AppConst.transparent,
    //           image: DecorationImage(
    //             image: NetworkImage(category.image),
    //             fit: BoxFit.fitHeight,
    //           ),

    //           // boxShadow: [
    //           //   BoxShadow(
    //           //     color: Colors.grey.withOpacity(0.5),
    //           //     blurRadius: 5,
    //           //     offset: Offset(2, 1),
    //           //   ),
    //           //],
    //         ),
    //       ),
    //     ),
    //     SizedBox(
    //       height: 1.h,
    //     ),
    //     Text(
    //       category.name,
    //       textAlign: TextAlign.center,
    //       overflow: TextOverflow.ellipsis,
    //       style: TextStyle(
    //           fontWeight: FontWeight.w700,
    //           fontFamily: 'MuseoSans',
    //           fontSize: SizeUtils.horizontalBlockSize * 3.31,
    //           color: AppConst.black),
    //     ),
    //     Text(
    //       category.subtitle,
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         fontWeight: FontWeight.w600,
    //         fontFamily: 'MuseoSans',
    //         fontSize: SizeUtils.horizontalBlockSize * 3.06,
    //         color: AppConst.green,
    //       ),
    //     ),
    //   ],
    // );
  }
}
