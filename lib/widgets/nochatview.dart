import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/theme/styles.dart';

class NoChatView extends StatelessWidget {
  const NoChatView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: SizeUtils.horizontalBlockSize * 25,
              backgroundColor: AppConst.white,
              backgroundImage: NetworkImage(
                "https://img.freepik.com/free-vector/chat-bot-concept-illustration_114360-5522.jpg?t=st=1650126755~exp=1650127355~hmac=535b7497e6ca14fd406e823062996a26cd10a28608bdf96882198ab4110eac0a&w=826",
              ),
            ),
            Container(
              height: SizeUtils.horizontalBlockSize * 8,
              width: SizeUtils.horizontalBlockSize * 75,
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "You've got no messages so far!",
                    style: TextStyle(
                        color: AppConst.black,
                        fontSize: SizeUtils.horizontalBlockSize * 8,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            SizedBox(
              height: SizeUtils.horizontalBlockSize * 1,
            ),
            Container(
              padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 2.55),
              height: SizeUtils.horizontalBlockSize * 14,
              width: SizeUtils.horizontalBlockSize * 68,
              child: Text(
                "As soon as someone sends you a message, I'll start appearing here.",
                style: AppStyles.STORES_SUBTITLE_STYLE,
              ),
            ),
            SizedBox(
              height: SizeUtils.horizontalBlockSize * 2,
            ),
            Container(
              height: SizeUtils.horizontalBlockSize * 10,
              width: SizeUtils.horizontalBlockSize * 65,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Start Chatting"),
                style:
                    ElevatedButton.styleFrom(primary: AppConst.kSecondaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
