import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'expense_provider.dart';
import 'home_screen.dart';


void main() {
  runApp(const CafeExpenseApp());
}

class CafeExpenseApp extends StatelessWidget {
  const CafeExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpenseProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Café Expense Tracker',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.brown,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
