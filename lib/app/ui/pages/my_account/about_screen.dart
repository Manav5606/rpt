import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/signIn/privacy_policy.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          'About',
          style: TextStyle(
            color: AppConst.black,
            fontFamily: 'MuseoSans',
            fontWeight: FontWeight.w700,
            fontSize: SizeUtils.horizontalBlockSize * 4,
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
              title: Text('Terms & Conditions'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => Get.to(AboutWebView(
                    title: "Terms and Conditions",
                    url: "https://recipto.in/TermsandConditions/terms/",
                  ))
              // launchUrlString('https://recipto.in/TermsandConditions/terms/'),
              ),
          ListTile(
              title: Text('Privacy Policy'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => Get.to(AboutWebView(
                    title: "Privacy Policy",
                    url: "https://recipto.in/TermsandConditions/privacy/",
                  ))
              // onTap: () => launchUrlString(
              //     'https://recipto.in/TermsandConditions/privacy/'),
              ),
          ListTile(
              title: Text('About us'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => Get.to(AboutWebView(
                    title: "About Us",
                    url: "https://recipto.in/TermsandConditions/terms/",
                  ))
              // onTap: () =>
              //     launchUrlString('https://recipto.in/TermsandConditions/terms/'),
              ),
          ListTile(
              title: Text('Contact us'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => Get.to(AboutWebView(
                    title: "Contact Us",
                    url: "https://recipto.in/About/contactUs/",
                  ))
              // onTap: () => launchUrlString('https://recipto.in/About/contactUs/'),
              ),
          ListTile(
              title: Text('Delete Account'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => Get.toNamed(AppRoutes.DeleteAccount)
              // onTap: () => launchUrlString('https://recipto.in/About/contactUs/'),
              ),
        ],
      ),
    );
  }
}
