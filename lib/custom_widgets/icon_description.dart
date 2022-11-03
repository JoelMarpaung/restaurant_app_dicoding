import 'package:flutter/material.dart';

class IconDescription extends StatelessWidget {
  final Icon icon;
  final String description;
  const IconDescription(
      {super.key, required this.icon, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 5),
        Text(
          description,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}
