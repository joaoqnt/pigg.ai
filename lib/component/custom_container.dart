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
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6)
      ),
      child: isLoading == true ? Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: iconColor
          ),
        ),
      ) : Icon(
        iconData,
        color: iconColor,
        size: 26,
      )
    );
  }
}
