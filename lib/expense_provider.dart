import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'expense.dart';

class ExpenseProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  ExpenseProvider() {
    fetchExpenses();
  }

  Future<void> fetchExpenses() async {
    final snapshot = await _db
        .collection('expenses')
        .orderBy('date', descending: true)
        .get();

    _expenses = snapshot.docs.map((doc) {
      final data = doc.data();
      return Expense(
        id: doc.id,
        title: data['title'],
        amount: (data['amount'] as num).toDouble(),
        category: ExpenseCategory.values[data['category']],
        date: (data['date'] as Timestamp).toDate(),
      );
    }).toList();

    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    final doc = await _db.collection('expenses').add({
      'title': expense.title,
      'amount': expense.amount,
      'category': expense.category.index,
      'date': expense.date,
    });

    expense.id = doc.id;
    _expenses.insert(0, expense);
    notifyListeners();
  }

  double get totalExpenses {
    return _expenses.fold(0, (sum, item) => sum + item.amount);
  }
}
