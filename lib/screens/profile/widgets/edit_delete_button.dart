import 'package:flutter/material.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:get/route_manager.dart';

class EditDeleteButton extends StatefulWidget {
  const EditDeleteButton({Key? key}) : super(key: key);

  @override
  _EditDeleteButtonState createState() => _EditDeleteButtonState();
}

class _EditDeleteButtonState extends State<EditDeleteButton> {
  ButtonMode _selection = ButtonMode.edit;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ButtonMode>(
      padding: EdgeInsets.zero,
      child: Icon(
        Icons.more_vert_outlined,
      ),
      onSelected: (ButtonMode result) {
        setState(() {
          _selection = result;
          if (_selection == ButtonMode.edit) {
            Get.toNamed(AppRoutes.AddLocationScreen);
          }
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<ButtonMode>>[
        const PopupMenuItem(
          value: ButtonMode.edit,
          child: Text('Edit'),
        ),
        const PopupMenuItem(
          value: ButtonMode.delete,
          child: Text('Delete'),
        ),
      ],
    );
  }
}

enum ButtonMode { edit, delete }
