import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:sizer/sizer.dart';

class StartReferring extends StatelessWidget {
  StartReferring({Key? key}) : super(key: key);

  final Map<double, Color> positions = {
    0: AppConst.green,
    30: AppConst.blue,
    60: AppConst.yellow,
    90: AppConst.orange,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppConst.kPrimaryColor,
                      child: Icon(Icons.person, color: AppConst.white),
                    ),
                    CircleImage(
                      position: 25,
                      color: AppConst.yellow,
                    ),
                    CircleImage(
                      position: 50,
                      color: AppConst.blue,
                    ),
                    CircleImage(
                      position: 75,
                      color: AppConst.green,
                    ),
                  ],
                ),
              ),
              Text(
                "Discover riends yet to join magicpin",
                style: TextStyle(
                  color: AppConst.white,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    primary: AppConst.white,
                    padding: EdgeInsets.all(13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () {
                    print("Start referring");
                  },
                  child: Text(
                    "Start Referring!",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: AppConst.kSecondaryColor,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CircleImage extends StatelessWidget {
  final Color color;
  final double position;
  const CircleImage({Key? key, required this.color, required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: color,
        child: Icon(Icons.person, color: AppConst.white),
      ),
    );
  }
}
