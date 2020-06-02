import 'package:flutter/material.dart';
import 'package:personalexpenses/components/expenses_chart.dart';
import 'package:personalexpenses/screens/add_new_expenses_screen.dart';
import 'file:///D:/flutter_dart/Flutter_applications/personal_expenses/lib/components/expenses_list_view.dart';

class ExpensesViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return AddNewExpenses();
                },
              );
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
                //   maxHeight: 150,
                ),
            child: ExpensesChart(),
          ),
          Expanded(
            flex: 2,
            child: ExpensesListView(),
          ),
        ],
      ),
    );
  }
}
