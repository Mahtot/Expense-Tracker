import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

var formatter = DateFormat.yMd();

class _NewExpenseState extends State<NewExpense> {
  final List<Expense> registeredExpenses = [];
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    ).then((value) {
      setState(() {
        _selectedDate = value;
      });
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    bool amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
           showDialog(
            context: context,
            builder: (ctx)=> AlertDialog(
              title: Text('Invalid Input'),
              content: Text('Please make sure a valid title, amount and date was entered.'),
              actions:[
                TextButton(
                  onPressed: (){Navigator.pop(ctx);},
                  child:Text('Okay'),
                )
              ]
            )
           );
           return;
        }
        else {
          final newExpense = Expense(
            title: _titleController.text,
            amount: enteredAmount,
            date: _selectedDate!,
            category: _selectedCategory,
          );
          registeredExpenses.add(newExpense);
          Navigator.pop(context);
        }
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            decoration: InputDecoration(label: Text('Title')),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: InputDecoration(
                    prefixText: '\$',
                    label: Text('Amount'),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Date Selected'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
