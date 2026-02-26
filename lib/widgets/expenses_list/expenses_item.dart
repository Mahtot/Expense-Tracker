import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.expense});

  final Expense expense;
  
  @override
  Widget build(context) {
    return Card(
      child: Text(expense.title)
    );
  }
}