
class Expense {
  final String id;
  final double amount;
  final String categoryId;
  final DateTime date;
  final String note;
  final String payee;
  final String tag;

  Expense({
    required this.id,
    required this.amount,
    required this.categoryId,
    required this.date,
    required this.note,
    required this.payee,
    required this.tag,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      amount: double.parse(json['amount']),
      categoryId: json['categoryId'],
      note: json['note'],
      date: DateTime.parse(json['date']),
      payee: json['payee'],
      tag: json['tag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'categoryId': categoryId,
      'note': note,
      'date': date.toIso8601String(),
      'payee': payee,
      'tag': tag,
    };
  }
}
