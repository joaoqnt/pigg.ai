import 'package:flutter/material.dart';
import 'package:piggai/styles.dart';

class CustomChoiceChip extends StatelessWidget {
  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  const CustomChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = Styles.primaryColor;
    final Color background = selected ? primary : Colors.grey.shade200;
    final Color textColor = selected ? Colors.white : Colors.grey.shade600;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => onSelected?.call(!selected),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: textColor,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
