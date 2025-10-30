import 'package:flutter/material.dart';

class CustomSmallAddButton extends StatelessWidget {
  final Function()? onTap;
  const CustomSmallAddButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap:  onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle
        ),
        child: Icon(Icons.add,color: colorScheme.onPrimary,),
      ),
    );
  }
}
