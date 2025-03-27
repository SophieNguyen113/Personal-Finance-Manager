class Expense {
  int? id;
  double amount;
  DateTime date;
  String category;
  String notes;

  Expense({this.id, required this.amount, required this.date, required this.category, required this.notes});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category,
      'notes': notes,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      category: map['category'],
      notes: map['notes'],
    );
  }
}
