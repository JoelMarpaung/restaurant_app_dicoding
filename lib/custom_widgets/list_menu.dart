import 'package:flutter/material.dart';

class ListMenu extends StatelessWidget {
  final String title;
  final List items;
  const ListMenu({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: items
                    .map(
                      (item) => Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.shade700,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          item.name,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
