import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesCard extends StatelessWidget {
  final String name;
  final double value;
  final DateTime dateTime;
  final void Function() onDeletePressed;

  String formatDate() {
    var dateFormat = DateFormat('EEE, MMM d');
    return dateFormat.format(dateTime);
  }

  ExpensesCard({this.name, this.value, this.dateTime, this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 10.0),
        leading: CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.purple,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '\$' + value.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        title: Text(name),
        subtitle: Text(formatDate()),
        trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red.shade700,
            ),
            onPressed: onDeletePressed),
      ),
    );
  }
}
