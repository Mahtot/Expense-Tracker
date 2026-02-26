import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.expense});

  final Expense expense;
  
  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children:[
            Text(expense.title),
            SizedBox(height: 4),
            Row(
              children: [
                Text('\$ ${expense.amount.toStringAsFixed(2)}'),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    SizedBox(width:4),
                    Text(expense.formattedDate),
                  ]
                )
              ]
            )
          ]
        ),
      )
    );
  }
}