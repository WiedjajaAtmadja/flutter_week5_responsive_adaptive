import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = _amountController.text.isNotEmpty
        ? double.parse(_amountController.text)
        : 0;
    if (enteredTitle.isNotEmpty && enteredAmount > 0) {
      widget.addTx(enteredTitle, enteredAmount, _selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Title'),
          controller: _titleController,
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Amount'),
          controller: _amountController,
          keyboardType: TextInputType.number,
        ),
        Row(
          children: [
            Expanded(
                child: Text(
                    'Picked Date: ${DateFormat.yMMMEd().format(_selectedDate)}')),
            TextButton(
                onPressed: _presentDatePicker, child: const Text('Choose Date'))
          ],
        ),
        ElevatedButton(
            onPressed: () => _submitData(),
            child: const Text('Add Transaction'))
      ],
    );
  }
}
