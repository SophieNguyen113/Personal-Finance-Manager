import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense_model.dart';
import '../controllers/expense_detail_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final Expense expense;
  final VoidCallback updateExpenses; // Accept the callback function

  ExpenseDetailScreen({required this.expense, required this.updateExpenses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Detail',
          style: GoogleFonts.kalam(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent.shade100,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Center(
                  child: Text(
                    'Category: ${expense.category}',
                    style: GoogleFonts.archivo(
                      color: Colors.black,
                      fontSize: 40,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'Amount: \$${expense.amount.toStringAsFixed(2)}',
                  style: GoogleFonts.notoSans(
                    color: Colors.black,
                    fontSize: 23,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Date: ${DateFormat.yMd().format(expense.date)}',
                  style: GoogleFonts.rubik(
                    color: Colors.black,
                    fontSize: 23,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Notes: ${expense.notes}',
                  style: GoogleFonts.rubik(
                    color: Colors.black,
                    fontSize: 23,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.shade100,
                          side: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: Text(
                          'Delete',
                          style: GoogleFonts.ibmPlexSansArabic(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          ExpenseDetailController(
                            expense: expense,
                            updateExpenses: updateExpenses,
                          ).deleteExpense(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
