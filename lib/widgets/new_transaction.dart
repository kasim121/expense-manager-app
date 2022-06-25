// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function(String a, double b, DateTime? selectedDate) addTx;
  const NewTransaction(this.addTx, {Key? key}) : super(key: key);

  @override 
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // const NewTransaction({ Key? key }) : super(key: key);
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
   DateTime? _selectedDate;
  void _submitData() {
    if(_amountController.text.isEmpty){
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate,

    );
    Navigator.pop(context);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {

      if(pickedDate == null){
     return; 
      }
 

    
    setState(() {
      _selectedDate = pickedDate;
    });
  });
    debugPrint('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => _submitData,
              // onChanged: (val){
              //   inputTitle = val;
              // },
              controller: _titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData,
              //   onChanged: (val){
              //   inputAmount = val;
              // },
              controller: _amountController,
            ),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                            _selectedDate == null ?'No Date Chosen' : 'Picked Date:  ${DateFormat.yMd().format(_selectedDate!)}',
                     
                    ),
                  ),
                  TextButton(
                    onPressed:_presentDatePicker,
                    child: const Text(
                     'Choose Date' ,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text(
                'Add Transaction',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
