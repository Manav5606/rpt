import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:customer_app/app/data/serivce/dynamic_link_service.dart';
import 'package:customer_app/app/utils/image_util.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:get/get.dart';

class ReferNEarnScreen extends StatefulWidget {
  const ReferNEarnScreen({Key? key}) : super(key: key);

  @override
  _ReferNEarnScreenState createState() => _ReferNEarnScreenState();
}

class _ReferNEarnScreenState extends State<ReferNEarnScreen> {
  final FlutterShareMe flutterShareMe = FlutterShareMe();
  final dynamicLinkSercive = Get.find<DynamicLinkService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Refer code \n\nABCDEFGH\n",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: shareToWhatsApp,
                  child: Text("Share via whatsapp"),
                  color: AppConst.green,
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                    onPressed: shareToSystem,
                    child: Text("Share"),
                    color: AppConst.kPrimaryColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void shareToWhatsApp() async {
    final link = await dynamicLinkSercive.createDynamicLink("ABCDEFGH");
    final image = await getImageFileFromAssets("images/account_banner.png");
    print("getImageFileFromAssets | asset path: ${image.path}");
    flutterShareMe.shareToWhatsApp(
        msg: "My earned balance is 300. You can join and earn also \n $link",
        imagePath: image.path);
  }

  void shareToSystem() async {
    final link = await dynamicLinkSercive.createDynamicLink("ABCDEFGH");
    flutterShareMe.shareToSystem(
        msg: "My earned balance is 300. You can join and earn also \n $link");
  }
}
