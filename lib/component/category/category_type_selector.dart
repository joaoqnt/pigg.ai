import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:piggai/styles.dart';
import 'package:piggai/controller/category_controller.dart';

class CategoryTypeSelector extends StatelessWidget {
  final CategoryController controller;
  const CategoryTypeSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Essa categoria é uma:",
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildOption("expense", "Despesa", Icons.trending_down_rounded),
              const SizedBox(width: 10),
              _buildOption("income", "Receita", Icons.trending_up_rounded),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildOption(String type, String title, IconData icon) {
    final bool selected = controller.type == type;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setType(type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: selected
                ? Styles.secondaryColor.withOpacity(0.12)
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? Styles.secondaryColor.withOpacity(0.5)
                  : Colors.transparent,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: selected ? Styles.primaryColor : Colors.grey.shade600,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: selected ? Styles.primaryColor : Colors.black87,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
