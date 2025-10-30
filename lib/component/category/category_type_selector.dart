import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:piggai/controller/category_controller.dart';

class CategoryTypeSelector extends StatelessWidget {
  final CategoryController controller;
  const CategoryTypeSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Observer(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tipo da categoria",
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 13),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _CategoryTypeButton(
                  label: "Despesa",
                  icon: Icons.trending_down_rounded,
                  isSelected: controller.type == "expense",
                  activeColor: Colors.red.shade600,
                  inactiveColor: theme.colorScheme.surfaceContainerLow,
                  onTap: () => controller.setType("expense"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _CategoryTypeButton(
                  label: "Receita",
                  icon: Icons.trending_up_rounded,
                  isSelected: controller.type == "income",
                  activeColor: Colors.green.shade600,
                  inactiveColor: theme.colorScheme.surfaceContainerLow,
                  onTap: () => controller.setType("income"),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}

class _CategoryTypeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const _CategoryTypeButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withOpacity(.12) : inactiveColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? activeColor : Colors.transparent,
            width: 1.4,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? activeColor : theme.iconTheme.color?.withOpacity(.6),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? activeColor : theme.colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
