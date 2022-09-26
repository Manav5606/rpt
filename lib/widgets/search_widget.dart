import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/data/models/search_model.dart';
import 'package:sizer/sizer.dart';

class SearchWidget extends StatelessWidget {
  final SearchModel search;
  const SearchWidget({Key? key, required this.search}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 70,
      child: Column(
        children: [
          Image.asset(
            search.image,
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              search.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppConst.black,
                fontSize: 11.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
