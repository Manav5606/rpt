import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/signInScreenController.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:customer_app/app/ui/pages/signIn/privacy_policy.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/utils/form_validator.dart';
import 'package:customer_app/widgets/signup_feilds.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SignupBs extends StatelessWidget {
  SignupBs({Key? key}) : super(key: key);

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _mobileNumberController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final SignInScreenController _signInController = Get.find();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool checkbox = false;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: 1.5.h, left: 3.w, right: 2.w, top: 1.h),
              child: Text(
                'Sign up now & earn \u{20B9}15 instantly',
                style: TextStyle(
                  fontSize: SizeUtils.horizontalBlockSize * 4.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
              width: double.infinity,
              color: Color(0xffe6faf1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u{20B9}125 Extra Cashback earned',
                    style: TextStyle(
                      color: AppConst.darkGreen,
                      fontFamily: 'MuseoSans',
                      fontWeight: FontWeight.w700,
                      fontSize: SizeUtils.horizontalBlockSize * 4.5,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'Enter the bill amount to get more Cashback',
                    style: TextStyle(
                      color: AppConst.darkGreen,
                      fontFamily: 'MuseoSans',
                      fontWeight: FontWeight.w300,
                      fontSize: SizeUtils.horizontalBlockSize * 3.8,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.userEdit,
                    size: 2.3.h,
                  ),
                  Text(
                    '   Edit Profile',
                    style: TextStyle(
                      fontFamily: 'MuseoSans',
                      fontWeight: FontWeight.w700,
                      fontSize: SizeUtils.horizontalBlockSize * 4,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 45.w,
                    child: SignUpFeilds(
                      hinttext: "Enter First name ",
                      // labelText: "Enter First name ",
                      controller: _firstNameController,
                      keyboardtype: TextInputType.name,
                      validator: (val) => FormValidator.validateString(val!),
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Container(
                    width: 45.w,
                    child: SignUpFeilds(
                      hinttext: "Enter Last name ",
                      // labelText: "Enter Last name ",
                      controller: _lastNameController,
                      keyboardtype: TextInputType.name,
                      validator: (val) => FormValidator.validateString(val!),
                    ),
                  ),
                ],
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 2.w),
            //   child: SignUpFeilds(
            //     hinttext: "+91 | Your Mobile Number ",
            //     // labelText: "+91 | Your Mobile Number ",
            //     keyboardtype: TextInputType.number,
            //      maxlength: 10,
            //     controller: _mobileNumberController,
            //     validator: (val) => FormValidator.validatePhoneNumber(val!),
            //   ),
            // ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: SignUpFeilds(
                hinttext: 'Enter your Email ID',
                // labelText: 'Enter your Email ID',

                controller: _emailController,
                validator: (val) => FormValidator.validateEmail(val!),
              ),
            ),
            Obx(
              () => CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Container(
                  width: 75.w,
                  child: InkWell(
                    onTap: () => Get.to(AboutWebView(
                      title: "Terms and Conditions ",
                      url: "https://recipto.in/TermsandConditions/terms/",
                    )),
                    child: RichText(
                        overflow: TextOverflow.visible,
                        text: TextSpan(children: [
                          TextSpan(
                            text: "I agree to the",
                            style: TextStyle(
                              color: AppConst.black,
                              fontFamily: 'MuseoSans',
                              fontWeight: FontWeight.w700,
                              fontSize: SizeUtils.horizontalBlockSize * 3.5,
                            ),
                          ),
                          TextSpan(
                            text: " Terms & Conditions and Privacy Policy",
                            style: TextStyle(
                              color: AppConst.green,
                              fontFamily: 'MuseoSans',
                              fontWeight: FontWeight.w700,
                              fontSize: SizeUtils.horizontalBlockSize * 3.5,
                            ),
                          )
                        ])),
                  ),
                ),
                value: _signInController.checkBox.value,
                onChanged: (value) {
                  _signInController.checkBox.value =
                      !_signInController.checkBox.value;
                },
              ),
            ),

            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate() &&
                        (_signInController.checkBox.value == true)) {
                      _signInController.signUpButton(_firstNameController.text,
                          _lastNameController.text, _emailController.text
                          // _mobileNumberController.text,
                          );
                    }
                  },
                  child: BottomWideButton(
                    text: 'Save Changes',
                    color: (_signInController.checkBox.value == true)
                        ? AppConst.darkGreen
                        : AppConst.grey,
                    borderColor: (_signInController.checkBox.value == true)
                        ? AppConst.darkGreen
                        : AppConst.grey,
                  ),
                ),
              ),
            ),
            // SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}
