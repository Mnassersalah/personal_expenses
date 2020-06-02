import 'package:flutter/material.dart';
import 'package:personalexpenses/classes/expenses_data.dart';
import 'package:personalexpenses/classes/expenses_item_class.dart';
import 'package:personalexpenses/constants.dart';
import 'package:provider/provider.dart';

class AddNewExpenses extends StatefulWidget {
  @override
  _AddNewExpensesState createState() => _AddNewExpensesState();
}

class _AddNewExpensesState extends State<AddNewExpenses> {
  String name;
  double value;
  DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            style: TextStyle(fontSize: 18.0),
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            onChanged: (newValue) {
              name = newValue;
            },
          ),
          TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 18.0),
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
            onChanged: (newValue) {
              value = double.parse(newValue);
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  color: kThemeColor.shade50,
                  child: Text(
                    date == null ? 'pick expenses date' : date.toString(),
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.calendar_today,
                  color: kThemeColor.shade300,
                ),
                onPressed: () async {
                  final DateTime pickedDate = await showDatePicker(
                    context: context,
                    initialDate: date == null ? DateTime.now() : date,
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      date = pickedDate;
                    });
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              color: kThemeColor,
              padding: EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
              onPressed: () {
                Provider.of<ExpensesData>(context, listen: false).addItem(
                  ExpensesItem(
                    name: name == null ? 'Expenses Item' : name,
                    date: date == null ? DateTime.now() : date,
                    value: value == null ? 0 : value,
                  ),
                );
                Navigator.pop(context);
              },
              child: Text(
                'ADD',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
