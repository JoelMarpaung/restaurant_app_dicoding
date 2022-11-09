import 'package:flutter/material.dart';

class DataNotFound extends StatelessWidget {
  final String message;
  const DataNotFound({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.search_off,
              size: 150,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
