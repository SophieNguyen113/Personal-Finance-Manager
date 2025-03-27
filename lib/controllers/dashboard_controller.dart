import 'package:flutter/material.dart';
import '../utils/screens_statefulwidgets.dart';

class DashboardController {
  static void navigateToExpenseEntry(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpenseEntryScreen()),
    );
  }

  static void navigateToBudgetSetup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BudgetSetupScreen()),
    );
  }

  static void navigateToReportsAndCharts(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReportsAndChartsScreen()),
    );
  }
}
