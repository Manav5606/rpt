import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuantityDropdown extends StatefulWidget {
  final int defaultSelected;
  final Function(int) onChanged;
  QuantityDropdown({this.defaultSelected = 0, required this.onChanged});

  @override
  State<QuantityDropdown> createState() => _QuantityDropdownState();
}

class _QuantityDropdownState extends State<QuantityDropdown> {
  int quantity = 0;

  bool get _inCart => quantity != 0;
  @override
  void initState() {
    quantity = widget.defaultSelected;
    super.initState();
  }

  void update(int value) {
    quantity = value;
    widget.onChanged(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!_inCart) {
      return InkWell(
        onTap: () => update(1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppConst.grey100, width: 1)),
          child: Text(
            "Add +",
            style: AppTextStyle.h5Regular(color: AppConst.green),
          ),
        ),
      );
    }

    return PopupMenuButton<int>(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onSelected: (value) {
        update(value);
      },
      // {

      // product.quntity!.value = value;
      // if (product.quntity!.value == 0) {
      //   product.isQunitityAdd?.value = false;
      // }
      // _moreStoreController.addToCart(
      //   store_id: sId,
      //   index: 0,
      //   increment: true,
      //   product: product,
      //   cart_id: _moreStoreController.addToCartModel.value?.sId ?? '',
      // );
      // totalCalculated();
      // },
      // offset: Offset(0.0, 40),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppConst.grey100, width: 1)),
        child: Text(
          quantity.toString(),
          style: AppTextStyle.h5Regular(color: AppConst.green),
        ),
      ),
      itemBuilder: (ctx) {
        return [
          PopupMenuItem(
            value: 0,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Quantity',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: SizeUtils.verticalBlockSize * 2,
                  ),
                ),
                SizedBox(
                  width: SizeUtils.horizontalBlockSize * 1,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.clear,
                    size: SizeUtils.verticalBlockSize * 3,
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(
            10,
            (index) => _buildPopupMenuItem(index),
          ),
        ];
      },
    );
  }

  PopupMenuItem<int> _buildPopupMenuItem(int value) {
    return PopupMenuItem<int>(
      value: value,
      padding: EdgeInsets.zero,
      // onTap: () => update(value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              value == 0 ? "Remove" : "$value",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: SizeUtils.verticalBlockSize * 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
