import 'package:flutter/material.dart';

class NavigationDrawerItem extends StatelessWidget {
  const NavigationDrawerItem({
    Key? key,
    required this.title,
    required this.leading,
  }) : super(key: key);

  final String title;
  final IconData leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              leading,
              size: 16,
              color: Colors.grey,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
