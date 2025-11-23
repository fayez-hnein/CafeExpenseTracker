import 'package:flutter/material.dart';
import 'expense.dart';

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _items = [];

  List<Expense> get items => List.unmodifiable(_items);

  void addExpense(Expense e) {
    _items.add(e);
    notifyListeners();
  }

  void updateExpense(String id, Expense updated) {
    final idx = _items.indexWhere((el) => el.id == id);
    if (idx >= 0) {
      _items[idx] = updated;
      notifyListeners();
    }
  }

  void deleteExpense(String id) {
    _items.removeWhere((el) => el.id == id);
    notifyListeners();
  }

  double get total => _items.fold(0, (sum, e) => sum + e.amount);
}
