import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, leisure, travel, grocery }

final Map CategoryIcons = {
  Category.food: Icons.fastfood_rounded,
  Category.leisure: Icons.movie,
  Category.travel: Icons.airplane_ticket,
  Category.grocery: Icons.shopping_basket_rounded,
};

class ExpensesStructure {
  ExpensesStructure({
    required this.name,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final Category category;

  String formattedDate() {
    return formatter.format(date);
  }
}

class chartStructure {
  chartStructure({required this.expenses, required this.category});
  //alternative constructor fucntion
  chartStructure.forCategory({
    required List<ExpensesStructure> allExpenses,
    required this.category,
  }) : expenses =
           allExpenses
               .where((expense) => expense.category == category)
               .toList();
  final Category category;
  final List<ExpensesStructure> expenses;

  double get totalSumofExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
