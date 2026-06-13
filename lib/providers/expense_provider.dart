import 'dart:convert';

import 'package:expense_manager/models/expense_category.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class ExpenseProvider with ChangeNotifier {
  final LocalStorage storage;

  /// EXPENSE
  List<Expense> _expenses = [];

  /// CATEGORY
  final List<ExpenseCategory> _categories = [
    ExpenseCategory(id: '1', name: 'Food', isDefault: true),
    ExpenseCategory(id: '2', name: 'Transport', isDefault: true),
    ExpenseCategory(id: '3', name: 'Entertainment', isDefault: true),
    ExpenseCategory(id: '4', name: 'Office', isDefault: true),
    ExpenseCategory(id: '5', name: 'Gym', isDefault: true),
  ];

  /// TAG
  final List<Tag> _tags = [
    Tag(id: '1', name: 'Breakfast'),
    Tag(id: '2', name: 'Lunch'),
    Tag(id: '3', name: 'Dinner'),
    Tag(id: '4', name: 'Treat'),
    Tag(id: '5', name: 'Cafe'),
    Tag(id: '6', name: 'Restaurant'),
    Tag(id: '7', name: 'Train'),
    Tag(id: '8', name: 'Vacation'),
    Tag(id: '9', name: 'Birthday'),
    Tag(id: '10', name: 'Diet'),
    Tag(id: '11', name: 'MovieNight'),
    Tag(id: '12', name: 'Tech'),
    Tag(id: '13', name: 'CarStuff'),
    Tag(id: '14', name: 'SelfCare'),
    Tag(id: '15', name: 'Streaming'),
  ];

  // GETTERS
  List<Expense> get expenses => _expenses;
  List<ExpenseCategory> get categories => _categories;
  List<Tag> get tags => _tags;

  ExpenseProvider(this.storage) {
    _loadExpensesFromStorage();
  }

  void _loadExpensesFromStorage() async {
    var storedExpenses = storage.getItem('expenses');
    if (storedExpenses != null) {
      _expenses = List<Expense>.from(
        (storedExpenses as List).map((expense) => Expense.fromJson(expense)),
      );
      notifyListeners();
    }
  }

  void _saveExpenseToStorage() {
    storage.setItem(
      'expenses',
      jsonEncode(_expenses.map((item) => item.toJson()).toList()),
    );
  }

  /// ======== EXPENSE =======

  // add expense
  void addExpense(Expense expense) {
    _expenses.add(expense);
    _saveExpenseToStorage();
    notifyListeners();
  }

  // add or update
  void addOrUpdateExpense(Expense updatedExpense) {
    var index = _expenses.indexWhere(
      (expense) => expense.id == updatedExpense.id,
    );

    if (index != -1) {
      _expenses[index] = updatedExpense;
    } else {
      _expenses.add(updatedExpense);
    }
    _saveExpenseToStorage();
    notifyListeners();
  }

  // remove
  void removeExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    _saveExpenseToStorage();
    notifyListeners();
  }

  // ======== CATEGORY =========

  // add category
  void addCategory(ExpenseCategory category) {
    if (!_categories.any((cat) => cat.name == category.name)) {
      _categories.add(category);
      notifyListeners();
    }
  }

  // remove
  void removeCategory(String id) {
    _categories.removeWhere((category) => category.id == id);
    notifyListeners();
  }

  // ======== TAG =========

  // add category
  void addTag(Tag tag) {
    if (!_tags.any((t) => t.id == tag.id)) {
      _tags.add(tag);
      notifyListeners();
    }
  }

  // remove
  void removeTag(String id) {
    _categories.removeWhere((tag) => tag.id == id);
    notifyListeners();
  }
  
}
