import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/data/models/search_model.dart';
import 'package:sizer/sizer.dart';

class SearchResultWidget extends StatelessWidget {
  final SearchModel result;
  const SearchResultWidget({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(result.image),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              result.description!,
              style: TextStyle(
                fontSize: 11.sp,
                color: AppConst.grey,
              ),
            ),
            if (result.status!.length > 0)
              Text(
                result.status ?? '',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppConst.kPrimaryColor,
                ),
              ),
          ],
        )
      ],
    );
  }
}
