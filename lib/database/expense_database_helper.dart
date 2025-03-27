import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/expense_model.dart';

class ExpenseDatabaseHelper {
  static ExpenseDatabaseHelper? _databaseHelper;
  static Database? _database;

  String expenseTable = 'expense_table';
  String colId = 'id';
  String colAmount = 'amount';
  String colDate = 'date';
  String colCategory = 'category';
  String colNotes = 'notes';

  ExpenseDatabaseHelper._();

  factory ExpenseDatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = ExpenseDatabaseHelper._();
    }
    return _databaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'expense.db');
    var expensesDatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return expensesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $expenseTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colAmount REAL, $colDate TEXT, '
            '$colCategory TEXT, $colNotes TEXT)');
  }

  Future<int> insertExpense(Expense expense) async {
    Database db = await this.database;
    var result = await db.insert(expenseTable, expense.toMap());
    return result;
  }

  Future<List<Expense>> getExpenseList() async {
    Database db = await this.database;
    var result = await db.query(expenseTable, orderBy: '$colDate DESC');
    List<Expense> expenseList =
    result.map((item) => Expense.fromMap(item)).toList();
    return expenseList;
  }

  Future<int> deleteExpense(int id) async {
    Database db = await this.database;
    return await db.delete(expenseTable, where: '$colId = ?', whereArgs: [id]);
  }

  Future<double> getTotalAmountSpentForCategory(
      String category, String startDate, String endDate) async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT SUM($colAmount) AS total FROM $expenseTable WHERE $colCategory = ? AND $colDate BETWEEN ? AND ?',
        [category, startDate, endDate]);

    // If there are no expenses for the given category, return 0.0
    if (result.first['total'] == null) {
      return 0.0;
    }

    // Parse the total amount from the result and return it
    return result.first['total'] as double;
  }
}
