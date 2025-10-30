import 'package:flutter/material.dart';

class CustomChoiceButton extends StatelessWidget {
  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  const CustomChoiceButton({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final surface = colorScheme.surfaceContainerHigh;
    final onSurface = colorScheme.onSurface;
    final outline = colorScheme.outlineVariant;

    final background = selected ? primary : surface;
    final textColor = selected ? colorScheme.onPrimary : onSurface.withOpacity(0.8);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => onSelected?.call(!selected),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? primary.withOpacity(0.2) : outline.withOpacity(0.4),
          ),
          boxShadow: selected
              ? [
            BoxShadow(
              color: primary.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ]
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: textColor,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
