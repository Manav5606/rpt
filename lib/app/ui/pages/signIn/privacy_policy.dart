import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutWebView extends StatelessWidget {
  final String? url;
  final String? title;

  AboutWebView({Key? key, this.url, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppConst.white,
            statusBarIconBrightness: Brightness.dark),
        elevation: 0,
        title: Text(
          title ?? "Terms & Conditions ",
          style: TextStyle(
            color: AppConst.black,
            fontFamily: 'MuseoSans',
            fontWeight: FontWeight.w700,
            fontSize: SizeUtils.horizontalBlockSize * 4,
          ),
        ),
      ),
      body: Center(
        child: WebView(
          initialUrl: url ?? 'https://recipto.in/TermsandConditions/terms/',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
