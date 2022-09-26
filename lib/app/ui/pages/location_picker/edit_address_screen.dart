import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/data/model/address_model.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/widgets/textfield_clear_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EditAddressScreen extends StatefulWidget {
  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  RxBool isDisabled = false.obs;

  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _howToReachController = TextEditingController();

  List<String> _tags = ["Home", "Work", "Hotel", "Other"];

  int _selectedTag = 0;
  AddressModel? addressModel;
  final AddLocationController _addLocationController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map arg = Get.arguments ?? {};
    addressModel = arg['addresses'];
    _floorController.text = addressModel?.house ?? '';
    _howToReachController.text = addressModel?.directionReach ?? '';
    var index = _tags.indexWhere((element) => element.toUpperCase() == addressModel?.title?.toUpperCase());
    if (index != -1) {
      _selectedTag = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 3.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Edit address ",
                                  style: TextStyle(
                                    fontSize: SizeUtils.horizontalBlockSize * 5,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.green
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                    iconSize: SizeUtils.horizontalBlockSize * 6.33,
                                    padding: EdgeInsets.zero,
                                    splashRadius: 25,
                                    visualDensity: VisualDensity(horizontal: -4),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(Icons.close)),
                                SizedBox(
                                  width: 2.w,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 1.h),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppConst.black, width: 0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 1.h, left: 3.w),
                                    child: Text(
                                      "YOUR LOCATION",
                                      style: TextStyle(
                                        color: AppConst.grey,
                                        fontSize: SizeUtils.horizontalBlockSize * 3,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 0.5.h, bottom: 1.h, left: 3.w, right: 2.w),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${addressModel?.address ?? ''}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: AppConst.grey,
                                              fontSize: SizeUtils.horizontalBlockSize * 4.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              TextFieldBox(
                                controller: _floorController,
                                hintText: "",
                                upperText: "Floor (Optional)",
                              ),
                              TextFieldBox(
                                controller: _howToReachController,
                                upperText: "How to reach (Optional)",
                                hintText: "",
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                children: _tags.asMap().entries.map((MapEntry map) => _buildTags(map.key)).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 2),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 7.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: isDisabled.value ? AppConst.grey : AppConst.kSecondaryColor,
                                  padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 3),
                                  ),
                                ),
                                onPressed: () {
                                  addressModel?.house = _floorController.text;
                                  addressModel?.directionReach = _howToReachController.text;
                                  _addLocationController.replaceCustomerAddress(addressModel);
                                  UserViewModel.setUser(_addLocationController.userModel!);
                                  Get.back();
                                },
                                child: Text(
                                  "Update Address",
                                  style: TextStyle(
                                    fontSize: SizeUtils.horizontalBlockSize * 5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding TextFieldBox({required TextEditingController? controller, required String? upperText, required String? hintText}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 1.h),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppConst.black, width: 0.3),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0.7.h, left: 3.w),
              child: Text(
                upperText!,
                style: TextStyle(
                  color: AppConst.grey,
                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 0.h, left: 3.w, right: 2.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      onChanged: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter valid details';
                        }
                      },
                      style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 4.5),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: SizeUtils.horizontalBlockSize * 2, top: SizeUtils.horizontalBlockSize * 1.27),
                        isDense: true,
                        hintText: hintText!,
                        // "Complete Address Details*",
                        hintStyle: isDisabled.value
                            ? TextStyle(color: AppConst.grey, fontSize: SizeUtils.horizontalBlockSize * 4.5)
                            : TextStyle(color: AppConst.grey, fontSize: SizeUtils.horizontalBlockSize * 4.5),
                        errorStyle: TextStyle(
                          color: AppConst.kPrimaryColor,
                        ),
                        enabled: !isDisabled.value,
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIconConstraints: BoxConstraints.tightFor(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppConst.black),
                        ),
                        suffixIcon: (controller?.text.length)! > 0
                            ? TextFieldClearButton(
                                onTap: () {
                                  controller?.clear();
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTags(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!isDisabled.value) {
            _selectedTag = index;
          }
        });
      },
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 2.w, top: 1.h, bottom: 1.h),
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.7.h),
            decoration: BoxDecoration(
                color: _selectedTag == index
                    ? isDisabled.value
                        ? AppConst.veryLightGrey
                        : AppConst.lightGrey
                    : AppConst.veryLightGrey,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: isDisabled.value ? AppConst.green : AppConst.grey)),
            child: Row(
              children: [
                Text(
                  "${_tags[index]} ",
                  style: TextStyle(
                      color: _selectedTag != index ? AppConst.grey : AppConst.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeUtils.horizontalBlockSize * 4),
                ),
                if (_selectedTag == index)
                  Icon(
                    Icons.verified_outlined,
                    color: AppConst.green,
                    size: SizeUtils.horizontalBlockSize * 3.5,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
