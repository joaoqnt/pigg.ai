import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
              _buildOption("expense", "Despesa", Icons.trending_down_rounded, context),
              const SizedBox(width: 10),
              _buildOption("income", "Receita", Icons.trending_up_rounded, context),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildOption(String type, String title, IconData icon, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool selected = controller.type == type;

    // Cores derivadas do tema
    final backgroundColor = selected
        ? colorScheme.primaryContainer
        : colorScheme.surfaceContainerLow;

    final borderColor = selected
        ? colorScheme.primary
        : Colors.transparent;

    final iconColor = selected
        ? colorScheme.onPrimaryContainer
        : colorScheme.onSurfaceVariant;

    final textColor = selected
        ? colorScheme.onPrimaryContainer
        : colorScheme.onSurface;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setType(type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
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
