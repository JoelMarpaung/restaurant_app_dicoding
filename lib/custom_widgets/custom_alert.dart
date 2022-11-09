import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../enums/alert_enum.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String content;
  final AlertEnum status;
  const CustomAlert({Key? key, required this.title, required this.content, required this.status}) : super(key: key);

  Color titleAlert(AlertEnum status){
    if(status == AlertEnum.success){
      return Colors.green;
    }else if(status == AlertEnum.warning){
      return Colors.yellow;
    }else{
      return Colors.red;
    }
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title, style: GoogleFonts.aBeeZee(color: titleAlert(status), fontSize: 25),),
      content: Text(content, style: Theme.of(context).textTheme.subtitle2,),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Close", style: Theme.of(context).textTheme.button,),
        )
      ],
    );
  }
}
