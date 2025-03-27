import 'package:flutter/material.dart';
import '../database/budget_database_helper.dart';
import '../database/expense_database_helper.dart';
import '../models/budget_model.dart';
import '../utils/dialog_widgets.dart';

class BudgetSetupController {
  String selectedCategory = 'Food'; // Set an initial value
  final TextEditingController amountController = TextEditingController();
  DateTime startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime endDate = DateTime.now().add(Duration(days: 1));
  final BudgetDatabaseHelper dbBudgetHelper = BudgetDatabaseHelper();
  final ExpenseDatabaseHelper dbExpenseHelper = ExpenseDatabaseHelper();

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate) {
      startDate = picked;
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != endDate) {
      endDate = picked;
    }
  }

  Future<void> saveBudget(BuildContext context) async {
    double amount = double.parse(amountController.text);

    Budget budget = Budget(
      category: selectedCategory,
      amount: amount,
      startDate: startDate,
      endDate: endDate,
    );

    await dbBudgetHelper.insertBudget(budget);

    // Check if the total amount spent for the selected category exceeds the budget amount
    bool exceedsBudget = await _checkBudgetExceeded(selectedCategory, amount, startDate, endDate);

    if (exceedsBudget) {
      DialogWidgets.showExceedDialog(context, selectedCategory);
    } else {
      DialogWidgets.showNotExceedDialog(context, selectedCategory);
    }

    // Clear the text fields after saving
    amountController.clear();
    // Reset selected category
    selectedCategory = 'Food'; // Set it back to the initial value
  }

  Future<bool> _checkBudgetExceeded(String category, double budgetAmount, DateTime startDate, DateTime endDate) async {
    double totalAmountSpent = await dbExpenseHelper.getTotalAmountSpentForCategory(category, startDate.toString(), endDate.toString());
    return totalAmountSpent > budgetAmount;
  }
}
