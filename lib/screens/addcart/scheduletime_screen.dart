import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ScheduleTimeScreen extends StatelessWidget {
  final AddCartController _addCartController = Get.find();

  // List<TempClass> _tempClassList = [
  //   TempClass(
  //     time: '1pm - 2pm',
  //     amount: '\₹0',
  //   ),
  //   TempClass(
  //     time: '2pm - 4pm',
  //     amount: '\₹0',
  //   ),
  //   TempClass(
  //     time: '3pm - 5pm',
  //     amount: '\₹0',
  //   ),
  //   TempClass(
  //     time: '4pm - 6pm',
  //     amount: '\₹0',
  //   ),
  //   TempClass(
  //     time: '5pm - 7pm',
  //     amount: '\₹0',
  //   ),
  //   TempClass(
  //     time: '6pm - 8pm',
  //     amount: '\₹0',
  //   ),
  //   TempClass(
  //     time: '7pm - 9pm',
  //     amount: '\₹0',
  //   ),
  // ];
  String tempText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        // leading: IconButton(
        //   icon: new Icon(
        //     Icons.clear,
        //     size: SizeUtils.horizontalBlockSize * 6,
        //     color: AppConst.black,
        //   ),
        //   onPressed: () {
        //     if (_addCartController.timeTitleCustom.value.isEmpty) {
        //       tempText = _addCartController.weekDayList[0].day ?? '';
        //       _addCartController.timeTitleCustom.value = tempText;
        //     }
        //     if (_addCartController.timeZoneCustom.value.isEmpty) {
        //       _addCartController.timeZoneCustom.value = getTemp(0);
        //     }
        //     Get.back();
        //   },
        // ),
        title: Row(
          children: [
            SizedBox(
              width: 2.w,
            ),
            Text(
              'Change Time',
              style: TextStyle(
                fontSize: SizeUtils.horizontalBlockSize * 5,
                fontWeight: FontWeight.w600,
                color: AppConst.black,
              ),
            ),
            Spacer(),
            IconButton(
              icon: new Icon(
                Icons.clear,
                size: SizeUtils.horizontalBlockSize * 6,
                color: AppConst.black,
              ),
              onPressed: () {
                if (_addCartController.timeTitleCustom.value.isEmpty) {
                  tempText = _addCartController.weekDayList[0].day ?? '';
                  _addCartController.timeTitleCustom.value = tempText;
                }
                if (_addCartController.timeZoneCustom.value.isEmpty) {
                  _addCartController.timeZoneCustom.value = getTemp(0);
                }
                Get.back();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _daySelection1(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Container(
                  height: 1.2.w,
                  color: AppConst.veryLightGrey,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                child: Text("Choose your desired Time Slot",
                    style: TextStyle(
                      fontFamily: 'MuseoSans',
                      color: AppConst.black,
                      fontSize: SizeUtils.horizontalBlockSize * 4,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    )),
              ),
              // _timeSlotList(),
              Obx(
                () => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          ((_addCartController.remainingSlotForDay?.length ??
                                  1) -
                              1),

                      // _addCartController
                      //         .getOrderConfirmPageDataModel
                      //         .value
                      //         ?.data
                      //         ?.deliverySlots?[
                      //             _addCartController.dayIndexForTimeSlot.value]
                      //         .slots
                      //         ?.length ??
                      //     0,
                      itemBuilder: (context, index) {
                        return Obx(
                          () {
                            return GestureDetector(
                              onTap: () {
                                if (_addCartController
                                        .selectedTimeIndex.value ==
                                    index) {
                                  _addCartController.selectedTimeIndex.value =
                                      -1;
                                } else {
                                  _addCartController.selectedTimeIndex.value =
                                      index;

                                  _addCartController
                                          .dayTimeSlots.value?.startTime =
                                      _addCartController
                                          .remainingSlotForDay![index]
                                          .startTime;
                                  // _addCartController
                                  //     .getOrderConfirmPageDataModel
                                  //     .value
                                  //     ?.data
                                  //     ?.deliverySlots?[int.parse(
                                  //         _addCartController.currentDay.value)]
                                  //     .slots?[index]
                                  //     .startTime;
                                  _addCartController
                                          .dayTimeSlots.value?.endTime =
                                      _addCartController
                                          .remainingSlotForDay![index].endTime;
                                  // _addCartController
                                  //     .getOrderConfirmPageDataModel
                                  //     .value
                                  //     ?.data
                                  //     ?.deliverySlots?[int.parse(
                                  //         _addCartController
                                  //             .currentDay.value)]
                                  //     .slots?[index]
                                  //     .endTime;

                                  _addCartController
                                          .dayTimeSlots.value?.cutOffTime =
                                      _addCartController
                                          .remainingSlotForDay![index]
                                          .cutOffTime;
                                  // _addCartController
                                  //     .getOrderConfirmPageDataModel
                                  //     .value
                                  //     ?.data
                                  //     ?.deliverySlots?[int.parse(
                                  //         _addCartController
                                  //             .currentDay.value)]
                                  //     .slots![index]
                                  //     .cutOffTime;

                                  _addCartController.timeZoneCustom.value =
                                      getTemp1(index);
                                }
                              },
                              child: Container(
                                height: 5.h,
                                child: Row(
                                  children: [
                                    IgnorePointer(
                                      child: Radio(
                                        activeColor: AppConst.darkGreen,
                                        value: index,
                                        groupValue: _addCartController
                                            .selectedTimeIndex.value,
                                        onChanged: (value) {
                                          _addCartController
                                                  .selectedTimeIndex.value ==
                                              value;
                                        },
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          getTemp1(index),
                                          style: TextStyle(
                                            color: AppConst.black,
                                            fontSize:
                                                SizeUtils.horizontalBlockSize *
                                                    3.8,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "MuseoSans",
                                            fontStyle: FontStyle.normal,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getTemp1(index) {
    var date1 =
        "${(_addCartController.remainingSlotForDay![index].startTime?.hour ?? 0) > 12 ? ((_addCartController.remainingSlotForDay![index].startTime?.hour ?? 0) - 12) : _addCartController.remainingSlotForDay![index].startTime?.hour}:${_addCartController.remainingSlotForDay![index].startTime?.minute}";
    var date2 =
        (_addCartController.remainingSlotForDay![index].startTime?.hour ?? 0) >
                12
            ? "PM - "
            : "AM - ";

    var date3 =
        "${(_addCartController.remainingSlotForDay![index].endTime?.hour ?? 0) > 12 ? ((_addCartController.remainingSlotForDay![index].endTime?.hour ?? 0) - 12) : _addCartController.remainingSlotForDay![index].endTime?.hour}:${_addCartController.remainingSlotForDay![index].endTime?.minute}";
    var date4 =
        (_addCartController.remainingSlotForDay![index].endTime?.hour ?? 0) > 12
            ? "PM"
            : "AM";

    var lastText = date1 + date2 + date3 + date4;
    return lastText;
  }

  String getTemp(index) {
    var date1 =
        "${(_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.hour ?? 0) > 12 ? ((_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.hour ?? 0) - 12) : _addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.hour}:${_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.minute}";
    var date2 = (_addCartController
                    .getOrderConfirmPageDataModel
                    .value
                    ?.data
                    ?.deliverySlots?[
                        _addCartController.dayIndexForTimeSlot.value]
                    .slots?[index]
                    .startTime
                    ?.hour ??
                0) >
            12
        ? "PM - "
        : "AM - ";

    var date3 =
        "${(_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].endTime?.hour ?? 0) > 12 ? ((_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].endTime?.hour ?? 0) - 12) : _addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].endTime?.hour}:${_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].endTime?.minute}";
    var date4 = (_addCartController
                    .getOrderConfirmPageDataModel
                    .value
                    ?.data
                    ?.deliverySlots?[
                        _addCartController.dayIndexForTimeSlot.value]
                    .slots?[index]
                    .endTime
                    ?.hour ??
                0) >
            12
        ? "PM"
        : "AM";

    var lastText = date1 + date2 + date3 + date4;
    return lastText;
  }

/*  Widget _timeSlotList() {
    return _addCartController
                .getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?.isNotEmpty ??
            false
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.w, top: 2.h),
                child: Text(
                  'Delivery Slots',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppConst.black,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: _addCartController
                          .getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?.length ??
                      0,
                  itemBuilder: (_, index) {
                    return Container(
                      color: AppConst.white,
                      child: Padding(
                        padding: EdgeInsets.all(5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${(_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.hour ?? 0) > 12 ? ((_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.hour ?? 0) - 12) : _addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.hour}:${_addCartController.getCartPageInformationModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.minute}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  (_addCartController.getOrderConfirmPageDataModel.value?.data
                                                  ?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.hour ??
                                              0) >
                                          12
                                      ? "PM - "
                                      : "AM - ",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  "${(_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].endTime?.hour ?? 0) > 12 ? ((_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].endTime?.hour ?? 0) - 12) : _addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].endTime?.hour}:${_addCartController.getCartPageInformationModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].endTime?.minute}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  (_addCartController.getOrderConfirmPageDataModel.value?.data
                                                  ?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].endTime?.hour ??
                                              0) >
                                          12
                                      ? "PM"
                                      : "AM",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            // FlutterSwitch(
                            //   value: _addCartController.deliverySlots[_addCartController.dayIndexForTimeSlot.value].slots[index].status.value,
                            //   width: 15.w,
                            //   height: 3.h,
                            //   onToggle: (value) {
                            //     if (_addCartController.deliverySlots[_addCartController.dayIndexForTimeSlot.value].status.value) {
                            //       _addCartController.deliverySlots[_addCartController.dayIndexForTimeSlot.value].slots[index].setStatus =
                            //           value;
                            //       _addCartController.deliverySlots.refresh();
                            //     }
                            //     _addCartController.deliverySlots.refresh();
                            //   },
                            //   activeColor: AppConst.primaryColor,
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : Column(
            children: [
              SizedBox(
                height: SizeUtils.verticalBlockSize * 5,
              ),
              Text('No Data Found!'),
            ],
          );
  }*/

  Widget _daySelection() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Container(
        height: 10.h,
        color: AppConst.white,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
          ),
          itemCount: _addCartController.weekDayList.length,
          addAutomaticKeepAlives: false,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
              ),
              child: Obx(
                () {
                  return GestureDetector(
                    onTap: () {
                      _addCartController.selectedDayIndex.value = index;
                      _addCartController.dayTimeSlots.value?.day =
                          _addCartController.deliverySlots[index]?.day ?? 0;
                      _addCartController.timeTitleCustom.value =
                          _addCartController.weekDayList[index].day ?? '';
                      _addCartController.dayIndexForTimeSlot.value =
                          _addCartController.weekDayList[index].value!;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            _addCartController.selectedDayIndex.value == index
                                ? AppConst.darkGreen
                                : AppConst.lightGrey,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 0.5,
                            color: _addCartController.selectedDayIndex.value ==
                                    index
                                ? AppConst.darkGreen
                                : AppConst.lightGrey),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: SizeUtils.verticalBlockSize * 0.5,
                              ),
                              Text(
                                _addCartController.weekDayList[index].date ??
                                    '',
                                style: TextStyle(
                                  fontSize: SizeUtils.horizontalBlockSize * 4,
                                  fontFamily: 'MuseoSans',
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: _addCartController
                                              .selectedDayIndex.value ==
                                          index
                                      ? AppConst.white
                                      : AppConst.black,
                                ),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Text(
                                index == 0
                                    ? "Today"
                                    : _addCartController.weekDayList[index].day
                                        .toString()
                                        .substring(0, 3)
                                        .toUpperCase(),
                                style: TextStyle(
                                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                                  fontFamily: 'MuseoSans',
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: _addCartController
                                              .selectedDayIndex.value ==
                                          index
                                      ? AppConst.white
                                      : AppConst.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _daySelection1() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Container(
        height: 10.h,
        color: AppConst.white,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
          ),
          itemCount: 2,
          addAutomaticKeepAlives: false,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
              ),
              child: Obx(
                () {
                  return GestureDetector(
                    onTap: () {
                      _addCartController.selectedDayIndex.value = index;
                      _addCartController.dayTimeSlots.value?.day =
                          _addCartController.deliverySlots[index]?.day ?? 0;
                      _addCartController.timeTitleCustom.value =
                          _addCartController.weekDayList[index].day ?? '';
                      _addCartController.dayIndexForTimeSlot.value =
                          _addCartController.weekDayList[index].value!;
                    },
                    child: Container(
                      width: 30.w,
                      decoration: BoxDecoration(
                        color:
                            _addCartController.selectedDayIndex.value == index
                                ? AppConst.darkGreen
                                : AppConst.lightGrey,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 0.5,
                            color: _addCartController.selectedDayIndex.value ==
                                    index
                                ? AppConst.darkGreen
                                : AppConst.lightGrey),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: SizeUtils.verticalBlockSize * 0.5,
                              ),
                              Text(
                                _addCartController.weekDayList[index].date ??
                                    '',
                                style: TextStyle(
                                  fontSize: SizeUtils.horizontalBlockSize * 4,
                                  fontFamily: 'MuseoSans',
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: _addCartController
                                              .selectedDayIndex.value ==
                                          index
                                      ? AppConst.white
                                      : AppConst.black,
                                ),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Text(
                                index == 0
                                    ? "Today"
                                    : _addCartController.weekDayList[index].day
                                        .toString()
                                        .substring(0, 3)
                                        .toUpperCase(),
                                style: TextStyle(
                                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                                  fontFamily: 'MuseoSans',
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: _addCartController
                                              .selectedDayIndex.value ==
                                          index
                                      ? AppConst.white
                                      : AppConst.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class TempClass {
  final String time;
  final String amount;

  TempClass({required this.time, required this.amount});
}
