import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:sizer/sizer.dart';
import 'package:timelines/timelines.dart';

class TimelineWidget extends StatelessWidget {
  const TimelineWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      child: Ink(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
        color: AppConst.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Timeline",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: SizeUtils.horizontalBlockSize * 5.5,
              ),
            ),
            Timeline.tileBuilder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              theme: TimelineThemeData(
                color: AppConst.green,
                nodePosition: 0,
              ),
              builder: TimelineTileBuilder.connected(
                connectorBuilder: (_, index, __) {
                  return SolidLineConnector(color: AppConst.lightGreen);
                },
                indicatorBuilder: (context, index) {
                  return OutlinedDotIndicator(
                    child: Icon(
                      Icons.done,
                      size: 2.h,
                      color: AppConst.white,
                    ),
                    size: 2.5.h,
                    backgroundColor: AppConst.green,
                  );
                },
                itemCount: 3,
                oppositeContentsBuilder: (context, index) => Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                    // child: Text(
                    //   "Order Placed succesfullly",
                    //   style: TextStyle(
                    //     fontSize: SizeUtils.horizontalBlockSize * 4,
                    //   ),
                    // ),
                    child: RichText(
                      text: TextSpan(
                          text: "4:05 PM",
                          style: TextStyle(
                            fontSize: SizeUtils.horizontalBlockSize * 4,
                            color: AppConst.darkGrey,
                          ),
                          children: [
                            TextSpan(
                              text: "  Order Placed succesfullly",
                              style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                color: AppConst.black,
                              ),
                            ),
                          ]),
                    )),
                contentsAlign: ContentsAlign.reverse,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
