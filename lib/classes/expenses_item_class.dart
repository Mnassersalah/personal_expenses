import 'package:flutter/material.dart';

class ExpensesItem {
  String name;
  double value;
  DateTime date;

  ExpensesItem({@required this.name, @required this.value, @required this.date});

  @override
  String toString() {
    return 'name: $name, date: $date, value: $value';
  }
}
