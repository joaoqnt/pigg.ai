import 'package:flutter/material.dart';

class ItemModalBottomComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Function()? onTap;

  const ItemModalBottomComponent({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(radius: 30,child: Icon(icon,size: 30,),),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(description,
                    style: TextStyle(fontSize: 12)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
