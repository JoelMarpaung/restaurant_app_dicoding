import 'package:flutter/material.dart';

class ServerError extends StatelessWidget {
  final String message;
  const ServerError({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.error_outlined, size: 150, color: Colors.white,),
            const SizedBox(height: 10,),
            Text(message, style: Theme.of(context).textTheme.headline6,),
          ],
        ),
      ),
    );
  }
}
