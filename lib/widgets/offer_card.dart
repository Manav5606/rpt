import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/theme/styles.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppConst.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     blurRadius: 5,
          //     offset: Offset(1, 1),
          //   ),
          // ],
          border: Border.all(color: AppConst.lightGrey)),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/logo1.jpg'),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Coscto",
                style: AppStyles.STORE_NAME_STYLE,
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "Delivery",
                style: AppStyles.STORES_SUBTITLE_STYLE,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Visited 3 minutes ago",
                style: AppStyles.STORES_SUBTITLE_STYLE,
              ),
            ],
          )
        ],
      ),
    );
  }
}
