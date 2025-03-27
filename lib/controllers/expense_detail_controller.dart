import 'package:flutter/material.dart';
import '../database/expense_database_helper.dart';
import '../models/expense_model.dart';

class ExpenseDetailController {
  final Expense expense;
  final VoidCallback updateExpenses; 
  final ExpenseDatabaseHelper _dbHelper = ExpenseDatabaseHelper();

  ExpenseDetailController({required this.expense, required this.updateExpenses});

  Future<void> deleteExpense(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueAccent.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(
              color: Colors.black,
              width: 3.0,
            ),
          ),
          title: const Center(
            child: Text(
              'Delete Expense',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          content: Text(
            'Are you sure you want to delete this expense?',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await _dbHelper.deleteExpense(expense.id!);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    updateExpenses();
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
