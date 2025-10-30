import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:piggai/component/custom/button/custom_choice_button.dart';
import 'package:piggai/controller/transaction_controller.dart';

class TransactionListCategory extends StatelessWidget {
  final TransactionController controller;
  const TransactionListCategory({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: [
              for(int i = 0; i < controller.categories.length; i ++)
                CustomChoiceButton(
                  text: controller.categories[i].name,
                  selected: controller.categories[i] == controller.categoryFilterSelected,
                  onSelected: (p0) => controller.setCategoryFilter(controller.categories[i]),
                )
            ],
          ),
        );
      }
    );
  }
}
