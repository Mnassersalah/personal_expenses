import 'package:personalexpenses/classes/expenses_item_class.dart';
import 'package:flutter/material.dart';

class ExpensesData extends ChangeNotifier {
  List<ExpensesItem> data = [];

  void addItem(ExpensesItem item) {
    data.add(item);
    notifyListeners();
  }

  void deleteItem(ExpensesItem item) {
    data.remove(item);
    notifyListeners();
  }

  double dayExpenses(int dayNumber) {
    final expensesList = data.where((element) => element.date.weekday == dayNumber);
    double result = 0;
    for (ExpensesItem item in expensesList) {
      result += item.value;
    }
    return result;
  }

  double maxDayExpenses() {
    double result = 0;
    for (int i = 1; i <= 7; i++) {
      if (dayExpenses(i) > result) {
        result = dayExpenses(i);
      }
    }
    return result == 0 ? 1 : 0;
  }
}
