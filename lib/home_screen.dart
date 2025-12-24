import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_expense_screen.dart';
import 'expense_provider.dart';
import 'expense_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cafe Expenses'),
      ),
      body: Column(
        children: [

          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Total Expenses: \$${provider.totalExpenses.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: provider.expenses.isEmpty
                ? const Center(child: Text('No expenses yet'))
                : ListView.builder(
              itemCount: provider.expenses.length,
              itemBuilder: (context, index) {
                return ExpenseTile(
                  expense: provider.expenses[index],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final expense = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddExpensePage(),
            ),
          );

          if (expense != null) {
            provider.addExpense(expense);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
