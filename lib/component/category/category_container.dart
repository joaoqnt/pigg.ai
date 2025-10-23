import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:piggai/component/category/category_modal_bottom.dart';
import 'package:piggai/component/custom_blur_dialog.dart';
import 'package:piggai/component/dialog/custom_delete_dialog.dart';
import 'package:piggai/controller/category_controller.dart';
import 'package:piggai/model/category_model.dart';
import 'package:piggai/util/color_util.dart';

class CategoryContainer extends StatelessWidget {
  final CategoryModel category;
  final CategoryController controller;

  CategoryContainer({
    super.key,
    required this.category,
    required this.controller,
  });


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {

        },
        onLongPress: () {
          CustomBlurDialog.show(
            context: context,
            mainContent: CategoryContainer(
              category: category,
              controller: controller,
            ),
            options: [
              BlurDialogOption(
                label: 'Editar',
                icon: Icons.edit,
                iconColor: Colors.black54,
                onTap: () {
                  CategoryModalBottom().show(context, controller, category: category);
                },
              ),
              BlurDialogOption(
                label: 'Excluir',
                icon: Icons.delete,
                iconColor: Colors.redAccent,
                onTap: () {
                  CustomDeleteDialog.show(context);
                  // ação de exclusão
                },
              ),
            ],
          );
        },

        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: ColorUtil().formatColor(category.color),
                child: Icon(
                  Icons.category,
                  color: ColorUtil().darken(
                      ColorUtil().formatColor(category.color),
                      0.25
                  ),
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      category.type == 'income' ? 'Receita' : 'Despesa',
                      style: const TextStyle(
                        fontSize: 12,
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
  }
}
