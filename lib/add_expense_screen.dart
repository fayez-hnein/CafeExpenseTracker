import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'expense.dart';
import 'expense_provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String amount = '';
  ExpenseCategory category = ExpenseCategory.Ingredients;
  DateTime date = DateTime.now();

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final expense = Expense(
      id: UniqueKey().toString(),
      title: title,
      amount: double.parse(amount),
      category: category,
      date: date,
    );
    Provider.of<ExpenseProvider>(context, listen: false).addExpense(expense);
    Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => date = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (v) => title = v,
                validator: (v) =>
                v == null || v.isEmpty ? 'Enter a title' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                onChanged: (v) => amount = v,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter an amount';
                  if (double.tryParse(v) == null) return 'Invalid number';
                  return null;
                },
              ),
              DropdownButtonFormField<ExpenseCategory>(
                value: category,
                decoration: const InputDecoration(labelText: 'Category'),
                items: ExpenseCategory.values
                    .map((c) => DropdownMenuItem(
                  value: c,
                  child: Text(c.name),
                ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => category = v);
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child:
                      Text('Date: ${DateFormat.yMMMd().format(date)}')),
                  TextButton(
                    onPressed: _pickDate,
                    child: const Text('Change'),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48)),
                child: const Text('Add Expense'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
