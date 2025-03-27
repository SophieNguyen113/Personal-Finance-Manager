import 'package:flutter/material.dart';

class DialogWidgets {
  
  static void showExceedDialog(BuildContext context, String selectedCategory) {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.pinkAccent.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0), 
              side: BorderSide(
                color: Colors.black,
                width: 3.0,
              ),
            ),
            title: const Center(
              child: Text(
                'Budget Exceeded',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold, 
                  fontSize: 20, 
                ),
              ),
            ),
            content: Text(
              'The budget for $selectedCategory has been exceeded.',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            actions: <Widget>[
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black, 
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error showing exceed dialog: $e');
    }
  }

  static void showNotExceedDialog(BuildContext context, String selectedCategory) {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.pinkAccent.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0), 
              side: BorderSide(
                color: Colors.black,
                width: 3.0,
              ),
            ),
            title: const Center(
              child: Text(
                'Budget Not Exceeded',
                style: TextStyle(
                  color: Colors.black, 
                  fontWeight: FontWeight.bold, 
                  fontSize: 20, 
                ),
              ),
            ),
            content: Text(
              'The budget for $selectedCategory has not been exceeded.',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            actions: <Widget>[
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error showing exceed dialog: $e');
    }
  }
}