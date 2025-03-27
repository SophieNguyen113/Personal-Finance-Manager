import 'package:flutter/material.dart';
import '../controllers/dashboard_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double buttonHeight = 60;
    final double buttonWidth = 115;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Welcome to Our Personal Finance Manager!",
                  style: GoogleFonts.caveat(
                    color: Colors.black,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 5.0, color: Colors.white),
          ),
        ),
        child: BottomAppBar(
          color: Colors.blueAccent.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(buttonWidth, buttonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  side: const BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                ),
                child: Text(
                  'Add\nExpense',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kalam(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  DashboardController.navigateToExpenseEntry(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(buttonWidth, buttonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  side: const BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                ),
                child: Text(
                  'Check\nBudget',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kalam(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  DashboardController.navigateToBudgetSetup(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(buttonWidth, buttonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  side: const BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                ),
                child: Text(
                  'Reports\nand Charts',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kalam(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  DashboardController.navigateToReportsAndCharts(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
