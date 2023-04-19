import 'dart:core';

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
      "assets/images/dryfruits.png",
      "assets/images/petfood.png",
      "assets/images/Medics.png",
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
        fit: BoxFit.fill,
      ),
    );
  }
}
