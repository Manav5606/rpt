import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/value_constants.dart';
import 'package:customer_app/utils/ui_spacing_helper.dart';
import 'package:customer_app/widgets/gradient_button.dart';

class SortDropDownIcon extends StatelessWidget {
  final onPress;

  const SortDropDownIcon({Key? key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: Row(
          children: [
            Text(
              'Sort by',
              style: AppConst.descriptionText2,
            ),
            Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
    );
  }
}

class SeeyaSortWidget extends StatefulWidget {
  final String? defaultSorting;
  final bool? showDistanceSort;
  final bool? showAZSort;

  final Function(String filterValue)? onSortApply;

  SeeyaSortWidget(
      {this.defaultSorting,
      this.onSortApply,
      this.showDistanceSort: true,
      this.showAZSort: true,
      Key? key})
      : super(key: key);

  @override
  _SeeyaSortWidgetState createState() => _SeeyaSortWidgetState();
}

class _SeeyaSortWidgetState extends State<SeeyaSortWidget> {
  String sortValue = SortValue.POPULAR;

  void onChange(value) => setState(() => sortValue = value);

  @override
  void initState() {
    sortValue = widget.defaultSorting ?? SortValue.POPULAR;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 40,
          child: RadioListTile(
            value: SortValue.POPULAR,
            groupValue: sortValue,
            onChanged: onChange,
            contentPadding: const EdgeInsets.all(0.0),
            activeColor: AppConst.themePurple,
            title: Text('Popular'),
          ),
        ),
        Visibility(
          visible: widget.showDistanceSort!,
          child: SizedBox(
            height: 40,
            child: RadioListTile(
              value: SortValue.DISTANCE,
              groupValue: sortValue,
              onChanged: onChange,
              contentPadding: const EdgeInsets.all(0.0),
              activeColor: AppConst.themePurple,
              title: Text('Distance'),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: RadioListTile(
            value: SortValue.CASHBACK,
            groupValue: sortValue,
            onChanged: onChange,
            contentPadding: const EdgeInsets.all(0.0),
            activeColor: AppConst.themePurple,
            title: Text('Cashback'),
          ),
        ),
        Visibility(
          visible: widget.showAZSort!,
          child: SizedBox(
            height: 40,
            child: RadioListTile(
              value: SortValue.AZ,
              groupValue: sortValue,
              onChanged: onChange,
              contentPadding: const EdgeInsets.all(0.0),
              activeColor: AppConst.themePurple,
              title: Text('A-Z'),
            ),
          ),
        ),
        UISpacingHelper.verticalSpaceMedium,
        Center(
          child: GradientButton(
            height: 45,
            onTap: () {
              if (widget.onSortApply != null) {
                widget.onSortApply!(sortValue);
              }
            },
            label: 'Done',
            fontStyle: TextStyle(fontSize: 18, color: AppConst.white),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
