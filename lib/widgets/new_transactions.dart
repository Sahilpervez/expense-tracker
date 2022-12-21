import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTranx;

  NewTransaction(this.addTranx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = num.parse(_amountController.text);
    if ((enteredTitle.isEmpty) || enteredAmount <= 0) {
      if (kDebugMode) {
        print("No new transactions added");
      }
      return ;
    }
    widget.addTranx(enteredTitle, enteredAmount,_selectedDate);
    Navigator.of(context).pop();
  }

  // The below function => _presentDatePicker() is no longer in use and _pickDateTime is used instead
  void _presentDatePicker() {
    // here we will use Future<> class of dart
    // this is a very important class this provides us with the
    // power to wait for the user input while the app process is being executed
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2002),
      lastDate: DateTime.now(),
    ).then((chosenDate) {
      if (chosenDate == null) {
        return;
      }
      setState(() {
        _selectedDate = chosenDate;
      });
    });
  }

  void _pickDateTime() async {
    DateTime? t1 = await pickDate();
    if (t1 == null) return;

    _selectedDate = t1;

    TimeOfDay? t2 = await pickTime();
    if (t2 == null) return;

    final datetime = DateTime(
      t1.year,
      t1.month,
      t1.day,
      t2.hour,
      t2.minute,
    );
    setState((){
      _selectedDate = datetime;
    });
  }

  Future<DateTime?> pickDate() async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2002),
      lastDate: DateTime.now(),
    );
  }

  Future<TimeOfDay?> pickTime() async {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: _selectedDate!.hour,
        minute: _selectedDate!.minute,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFEFD6F3),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              onEditingComplete: () {
                _submitData();
              },
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle: TextStyle(color: Colors.purple, fontSize: 16),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple,
                    width: 1.3,
                  ),
                ),
              ),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              onEditingComplete: () {
                _submitData();
              },
              decoration: InputDecoration(
                labelText: "Amount",
                labelStyle: TextStyle(color: Colors.purple, fontSize: 16),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple, width: 1.3),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              // height: 70,
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      (_selectedDate == null)
                          ? "No date chosen!"
                          : "Picked Date: ${DateFormat.yMMMd().format(_selectedDate!)}\nPicked Time: ${DateFormat.jm().format(_selectedDate!)}",
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _pickDateTime();
                    },
                    child: Text(
                      "Choose Date",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // backgroundColor: Color(0xffe8e1ea),
                backgroundColor: Colors.purple,
              ),
              onPressed: _submitData,
              child: Text(
                "Add Transaction",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
