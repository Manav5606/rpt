import 'package:customer_app/app/ui/pages/my_account/delete_account_final_screen.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../../../routes/app_list.dart';
import '../signIn/privacy_policy.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(top: 1.h, left: 5.w),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppConst.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Deactivate Account",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
              ),
              Text(
                "Why would you lke to delete your account?",
                style: TextStyle(color: AppConst.grey, fontSize: 15),
              ),
              SizedBox(
                height: 5.h,
              ),
              Column(
                children: [
                  ListTile(
                      title: Text('I don\'t want to use Recipto anymore'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () => Get.to(DeleteAcccountFinalScreen(
                            reason: "I don\'t want to use Recipto anymore",
                          ))
                      // launchUrlString('https://recipto.in/TermsandConditions/terms/'),
                      ),
                  ListTile(
                      title: Text('I\'m using a different account'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () => Get.to(DeleteAcccountFinalScreen(
                            reason: "I\'m using a different account",
                          ))
                      // onTap: () => launchUrlString(
                      //     'https://recipto.in/TermsandConditions/privacy/'),
                      ),
                  ListTile(
                      title: Text('I\'m worried about my privacy'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () => Get.to(DeleteAcccountFinalScreen(
                            reason: "About Us",
                          ))
                      // onTap: () =>
                      //     launchUrlString('https://recipto.in/TermsandConditions/terms/'),
                      ),
                  ListTile(
                      title: Text(
                          'You\'re sending me too many emails/notifictaions'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () => Get.to(DeleteAcccountFinalScreen(
                            reason:
                                "You\'re sending me too many emails/notifictaions",
                          ))
                      // onTap: () => launchUrlString('https://recipto.in/About/contactUs/'),
                      ),
                  ListTile(
                      title: Text('The app is not working properly'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () => Get.to(DeleteAcccountFinalScreen(
                            reason: "The app is not working properly",
                          ))
                      // onTap: () => launchUrlString('https://recipto.in/About/contactUs/'),
                      ),
                  ListTile(
                      title: Text('Other'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () => Get.to(DeleteAcccountFinalScreen(
                            reason: "Other",
                          ))
                      // onTap: () => launchUrlString('https://recipto.in/About/contactUs/'),
                      ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
