import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';

class DummySearchField extends StatelessWidget {
  const DummySearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.Search),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2,
        child: Container(
          height: 42,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppConst.lightGrey,
              )),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(
                  Icons.search,
                  color: AppConst.kPrimaryColor,
                ),
              ),
              Expanded(
                child: Text(
                  "Restaurent names, cuisine or dish ...",
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    fontSize: 14.sp,
                    color: AppConst.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
