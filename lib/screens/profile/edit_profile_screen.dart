import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/signIn/signup_screen.dart';
import 'package:customer_app/widgets/signup_feilds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/app/controller/signInScreenController.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen_shimmer.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/widgets/textfield_clear_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _handleController = TextEditingController();
  // final TextEditingController _stateController = TextEditingController();
  // final TextEditingController _descriptionController = TextEditingController();
  final SignInScreenController _signInController =
      Get.put(SignInScreenController());
  final MyAccountController _Controller = Get.find();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      bottomSheet: GestureDetector(
          onTap: () async {
            _signInController.UpdateInfo(firstNameController.text,
                lastNameController.text, mobileNumberController.text);
          },

          // onTap: (_signInController
          //             .phoneNumberController.value.text.length ==
          //         10)
          //     ? () {
          //         _signInController.submitPhoneNumber();
          //       }
          //     : null,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: BottomWideButton(
              text: "Update Profile ",
            ),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Obx(
          () => _signInController.isLoading.value
              ? SignupScreenShimmerEffect()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.black,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize:
                                      SizeUtils.horizontalBlockSize * 4.7),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Container(
                          //       width: 45.w,
                          //       child: SignUpFeilds(
                          //         labelText: "First Name*",

                          //         hinttext: (_Controller.user.firstName) ??
                          //             "First name", //"Enter your first name ",
                          //         controller: firstNameController,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 3.w,
                          //     ),
                          //     Container(
                          //       width: 45.w,
                          //       child: SignUpFeilds(
                          //         labelText: "Last Name*",

                          //         hinttext: _Controller.user.lastName ??
                          //             "Last name", //"Enter your last name ",
                          //         controller: lastNameController,
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          SignUpFeilds(
                            labelText: "First Name*",

                            hinttext: (_Controller.user.firstName) ??
                                "First name", //"Enter your first name ",
                            controller: firstNameController,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          SignUpFeilds(
                            labelText: "Last Name*",

                            hinttext: _Controller.user.lastName ??
                                "Last name", //"Enter your last name ",
                            controller: lastNameController,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),

                          SignUpFeilds(
                            labelText: "Email ID",
                            hinttext: _Controller
                                .user.email, //"Enter your last name ",
                            controller: mobileNumberController,
                            readOnly: true,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          SignUpFeilds(
                            labelText: "Mobile Number*",
                            hinttext: _Controller
                                .user.mobile, //"Enter your last name ",
                            controller: mobileNumberController,
                            readOnly: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );

    // Scaffold(
    //   appBar: AppBar(
    //     elevation: 0,
    //   ),
    //   body: SingleChildScrollView(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         ReceiptoContainer(),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text("Profile Photo", style: TextStyle(color: AppConst.grey)),
    //               SizedBox(height: 5),
    //               EditPhoto(),
    //               Divider(
    //                 color: AppConst.grey,
    //                 thickness: 1,
    //               ),
    //               SizedBox(height: 5),
    //               TextFormField(
    //                 controller: _nameController,
    //                 onChanged: (val) {
    //                   setState(() {});
    //                 },
    //                 decoration: InputDecoration(
    //                   contentPadding: EdgeInsets.only(bottom: 10, top: 20),
    //                   isDense: true,
    //                   hintText: "SITA 222",
    //                   suffixIconConstraints: BoxConstraints.tightFor(),
    //                   suffixIcon: _nameController.text.length > 0
    //                       ? TextFieldClearButton(
    //                           onTap: () {
    //                             _nameController.clear();
    //                             setState(() {});
    //                           },
    //                         )
    //                       : null,
    //                 ),
    //               ),
    //               SizedBox(height: 10),
    //               TextFormField(
    //                 controller: _handleController,
    //                 onChanged: (val) {
    //                   setState(() {});
    //                 },
    //                 decoration: InputDecoration(
    //                   contentPadding: EdgeInsets.only(bottom: 10, top: 20),
    //                   isDense: true,
    //                   suffixIconConstraints: BoxConstraints.tightFor(),
    //                   hintText: "Handle",
    //                   helperText: "Handle cannot be changed once set",
    //                   suffixIcon: _handleController.text.length > 0
    //                       ? TextFieldClearButton(
    //                           onTap: () {
    //                             _handleController.clear();
    //                             setState(() {});
    //                           },
    //                         )
    //                       : null,
    //                 ),
    //               ),
    //               SizedBox(height: 20),
    //               Text(
    //                 "Phone Number",
    //                 style: TextStyle(
    //                   color: AppConst.grey,
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8.0),
    //                 child: Row(
    //                   children: [
    //                     Container(
    //                       height: 25,
    //                       width: 40,
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(5),
    //                         color: AppConst.green,
    //                       ),
    //                     ),
    //                     Text(
    //                       "  +91  ",
    //                       style: TextStyle(
    //                         fontSize: 18,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     Container(
    //                       height: 25,
    //                       width: 2,
    //                       color: AppConst.black,
    //                     ),
    //                     SizedBox(
    //                       width: 10,
    //                     ),
    //                     Text(
    //                       "9000084845",
    //                       style: TextStyle(
    //                         fontSize: 18,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     Spacer(),
    //                     InkWell(
    //                         onTap: () {},
    //                         child: Text(
    //                           "Change",
    //                           style: TextStyle(
    //                             color: AppConst.kPrimaryColor,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ))
    //                   ],
    //                 ),
    //               ),
    //               Divider(
    //                 color: AppConst.grey,
    //                 thickness: 1,
    //               ),
    //               TextFormField(
    //                 controller: _stateController,
    //                 onChanged: (val) {
    //                   setState(() {});
    //                 },
    //                 decoration: InputDecoration(
    //                   contentPadding: EdgeInsets.only(bottom: 10, top: 20),
    //                   isDense: true,
    //                   hintText: "Hyderabad",
    //                   suffixIconConstraints: BoxConstraints.tightFor(),
    //                   suffixIcon: _stateController.text.length > 0
    //                       ? TextFieldClearButton(
    //                           onTap: () {
    //                             _stateController.clear();
    //                             setState(() {});
    //                           },
    //                         )
    //                       : null,
    //                 ),
    //               ),
    //               SizedBox(height: 10),
    //               TextFormField(
    //                 controller: _descriptionController,
    //                 onChanged: (val) {
    //                   setState(() {});
    //                 },
    //                 decoration: InputDecoration(
    //                   contentPadding: EdgeInsets.only(bottom: 10, top: 20),
    //                   isDense: true,
    //                   hintText:
    //                       "Tell us a little about yourself ( in less than 150 words )",
    //                   suffixIconConstraints: BoxConstraints.tightFor(),
    //                   suffixIcon: _descriptionController.text.length > 0
    //                       ? TextFieldClearButton(
    //                           onTap: () {
    //                             _descriptionController.clear();
    //                             setState(() {});
    //                           },
    //                         )
    //                       : null,
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Row(
    //                 children: [
    //                   Expanded(
    //                     child: ElevatedButton(
    //                       style: ElevatedButton.styleFrom(
    //                         elevation: 0,
    //                         primary: AppConst.kSecondaryTextColor,
    //                         padding: EdgeInsets.all(13),
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(5.0),
    //                         ),
    //                       ),
    //                       onPressed: () {},
    //                       child: Text(
    //                         "Save Changes",
    //                         style: TextStyle(
    //                           fontSize: 15.sp,
    //                           fontWeight: FontWeight.w500,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}

class EditPhoto extends StatelessWidget {
  const EditPhoto({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/image4.png'),
        ),
        SizedBox(
          width: 10,
        ),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 2),
            side: BorderSide(
              color: AppConst.white,
            ),
            primary: AppConst.kPrimaryColor,
          ),
          onPressed: () {},
          icon: Icon(
            Icons.camera_alt,
            size: 18,
          ),
          label: Text(
            "Edit Photo",
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }
}

class ReceiptoContainer extends StatelessWidget {
  const ReceiptoContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppConst.kPrimaryColor,
            AppConst.kSecondaryTextColor,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              StringContants.receipto,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22.sp,
                letterSpacing: 1,
                color: AppConst.white,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 5,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  primary: AppConst.black,
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.camera_alt,
                  size: 15,
                ),
                label: Text("Edit")),
          )
        ],
      ),
    );
  }
}
