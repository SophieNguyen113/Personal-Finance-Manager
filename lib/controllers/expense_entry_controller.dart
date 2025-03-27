import 'package:flutter/material.dart';
import '../database/expense_database_helper.dart';
import '../models/expense_model.dart';

class ExpenseEntryController {
  final TextEditingController amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String selectedCategory = 'Food'; // Set an initial value
  final TextEditingController notesController = TextEditingController();
  final dbHelper = ExpenseDatabaseHelper();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }

  void saveExpense(BuildContext context) async {
    double amount = double.parse(amountController.text);
    String notes = notesController.text;

    Expense expense = Expense(
      amount: amount,
      date: selectedDate,
      category: selectedCategory,
      notes: notes,
    );

    await dbHelper.insertExpense(expense);

    // Clear the text fields after saving
    amountController.clear();
    notesController.clear();
    // Reset selected category
    selectedCategory = 'Food'; // Set it back to the initial value

    // Navigate back to the previous screen
    Navigator.pop(context);
  }
}
