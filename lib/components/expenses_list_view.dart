import 'package:flutter/material.dart';
import 'package:personalexpenses/classes/expenses_data.dart';
import 'package:personalexpenses/components/expenses_card.dart';
import 'package:provider/provider.dart';

class ExpensesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesData>(
      builder: (context, expensesData, child) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: expensesData.data.length,
          itemBuilder: (context, index) {
            final expensesItem = expensesData.data[index];
            return ExpensesCard(
              name: expensesItem.name,
              value: expensesItem.value,
              dateTime: expensesItem.date,
              onDeletePressed: () {
                Provider.of<ExpensesData>(context, listen: false).deleteItem(expensesItem);
              },
            );
          },
        );
      },
    );
  }
}
