enum ExpenseCategory {
  Ingredients,
  Wages,
  Maintenance,
  RentUtilities,
  Other,
}

extension ExpenseCategoryExt on ExpenseCategory {
  String get name {
    switch (this) {
      case ExpenseCategory.Ingredients:
        return 'Ingredients';
      case ExpenseCategory.Wages:
        return 'Wages';
      case ExpenseCategory.Maintenance:
        return 'Maintenance';
      case ExpenseCategory.RentUtilities:
        return 'Rent & Utilities';
      default:
        return 'Other';
    }
  }
}

class Expense {
  String id;
  String title;
  double amount;
  ExpenseCategory category;
  DateTime date;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });
}
