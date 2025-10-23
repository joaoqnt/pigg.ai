import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Color backgroundColor;
  final IconData iconData;
  final Color iconColor;
  final bool? isLoading;

  const CustomContainer({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    required this.iconData,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(
              color: iconColor
          )
      ),
      child: isLoading == true ? Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: iconColor
          ),
        ),
      ) : Icon(
        iconData,
        color: iconColor,
        size: 32,
      )
    );
  }
}
