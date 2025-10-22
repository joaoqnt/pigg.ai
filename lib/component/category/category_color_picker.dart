import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:piggai/controller/category_controller.dart';

class CategoryColorPicker extends StatelessWidget {
  final CategoryController controller;
  const CategoryColorPicker({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: controller.colorSelected,
                      onColorChanged: (color) => controller.setColor(color),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: controller.colorSelected,
              shape: BoxShape.circle
            ),
          ),
        );
      }
    );
  }
}
