import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';

class RewardsCard extends StatelessWidget {
  final String offerName;
  final String imageUrl;
  const RewardsCard({
    Key? key,
    required this.offerName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Image.asset(
            imageUrl,
            height: 70,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              offerName,
              style: TextStyle(color: AppConst.white),
            ),
          )
        ],
      ),
    );
  }
}
