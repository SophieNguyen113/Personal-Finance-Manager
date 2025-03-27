import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../database/expense_database_helper.dart';
import '../models/expense_model.dart';
import '../screens/expense_detail_screen.dart';
import '../utils/category_total.dart';

class ReportsAndChartsController {
  List<Expense> expenseList = [];
  final dbHelper = ExpenseDatabaseHelper();

  Future<void> getExpenses() async {
    List<Expense> expenses = await dbHelper.getExpenseList();
    expenseList = expenses;
  }

  Widget buildEmptyState() {
    return Center(
      child: Text(
        'No expenses recorded',
        style: GoogleFonts.rubik(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }

Widget buildCharts(BuildContext context, VoidCallback updateExpenses) {
  Map<String, double> categoryTotalMap = _calculateCategoryTotal(expenseList);
  List<charts.Series<CategoryTotal, String>> seriesList = [
    charts.Series(
      id: 'CategoryTotal',
      data: categoryTotalMap.entries
          .map((entry) => CategoryTotal(entry.key, entry.value))
          .toList(),
      domainFn: (CategoryTotal categoryTotal, _) => categoryTotal.category,
      measureFn: (CategoryTotal categoryTotal, _) => categoryTotal.total,
    )
  ];
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: SizedBox(
          height: 200,
          child: charts.BarChart(
            seriesList,
            animate: true,
            vertical: false,
          ),
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: expenseList.length,
          itemBuilder: (context, index) {
            Expense expense = expenseList[index];
            Color? backgroundColor = Colors.blueAccent.shade100;
            return Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: ListTile(
                title: Text(
                  expense.category,
                  style: GoogleFonts.rubik(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  '\$${expense.amount.toStringAsFixed(2)} - ${DateFormat.yMd().format(expense.date)}',
                  style: GoogleFonts.rubik(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  _navigateToExpenseDetailScreen(context, expense, updateExpenses);
                },
              ),
            );
          },
        ),
      ),
    ],
  );
}



  void _navigateToExpenseDetailScreen(BuildContext context, Expense expense, VoidCallback updateExpenses) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseDetailScreen(expense: expense, updateExpenses: updateExpenses),
      ),
    );
  }

  Map<String, double> _calculateCategoryTotal(List<Expense> expenses) {
    Map<String, double> categoryTotalMap = {};

    for (Expense expense in expenses) {
      if (categoryTotalMap.containsKey(expense.category)) {
        categoryTotalMap[expense.category] =
            (categoryTotalMap[expense.category] ?? 0) + expense.amount;
      } else {
        categoryTotalMap[expense.category] = expense.amount;
      }
    }

    return categoryTotalMap;
  }
}
