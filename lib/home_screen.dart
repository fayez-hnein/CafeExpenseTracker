import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_expense_screen.dart';
import 'expense_provider.dart';
import 'expense_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);
    final expenses = provider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Café Expense Tracker'),
      ),
      body: expenses.isEmpty
          ? const Center(child: Text('No expenses yet. Tap + to add one.'))
          : ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, i) {
          final e = expenses[i];
          return ExpenseTile(expense: e);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'Total: \$${provider.total.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
