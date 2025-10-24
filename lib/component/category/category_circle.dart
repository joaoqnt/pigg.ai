import 'package:flutter/material.dart';
import 'package:piggai/model/category_model.dart';
import 'package:piggai/util/color_util.dart';

class CategoryCircle extends StatelessWidget {
  final CategoryModel category;
  final bool? isSelected;
  final void Function()? onTap;

  const CategoryCircle({
    super.key,
    required this.category,
    this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = ColorUtil().formatColor(category.color);
    final darkColor = ColorUtil().darken(color);

    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔵 Bolinha animada
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              width: isSelected == true ? 35 : 30,
              height: isSelected == true ? 35 : 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(
                  color: darkColor,
                  width: isSelected == true ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isSelected == true ? 0.35 : 0.15),
                    blurRadius: isSelected == true ? 8 : 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: isSelected == true ? 1.1 : 1.0,
                  curve: Curves.easeOut,
                  child: Icon(
                    Icons.category_outlined,
                    color: darkColor,
                    size: isSelected == true ? 20 : 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 6),

            // 🏷️ Texto animado
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              style: TextStyle(
                fontSize: isSelected == true ? 12 : 10,
                color: Colors.black,
              ),
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
