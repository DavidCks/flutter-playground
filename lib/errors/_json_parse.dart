import 'package:flutter/material.dart';

void throwJsonParseError(BuildContext context) {
  print("JSON parsing failed");
  // Show an error message to the user
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("An error occurred while parsing the JSON data"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

void throwMissingKeyError(BuildContext context, String fieldName, int index) {
  print(
      "Parsed JSON object doesn't have required field ${fieldName}, index: ${index}");
  // Show an error message to the user
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(
              "JSON data needs to include a field called ${fieldName}\n This Error occured in object ${index}"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
