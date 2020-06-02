import 'package:flutter/material.dart';
import 'package:personalexpenses/constants.dart';
import 'package:personalexpenses/screens/expenses_view_screen.dart';
import 'package:provider/provider.dart';
import 'package:personalexpenses/classes/expenses_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpensesData(),
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          primaryColor: kThemeColor,
          cursorColor: kThemeColor,
          accentColor: kThemeColor,
        ),
        home: ExpensesViewScreen(),
      ),
    );
  }
}
