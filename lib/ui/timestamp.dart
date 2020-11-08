import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdatedStatusString extends StatelessWidget {
  final DateTime text;

  const LastUpdatedStatusString({Key key, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        formatTimeStamp(text),
        textAlign: TextAlign.center,
      ),
    );
  }
}

String formatTimeStamp(DateTime text) {
  if (text == null) {
    return '';
  }

  var formatter = DateFormat.yMd().add_Hms();
  var formatted = formatter.format(text);

  return 'Last Update: $formatted';
}
