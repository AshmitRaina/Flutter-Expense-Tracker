import 'package:expense_tracker_revision/expense_list_item.dart';
import 'package:expense_tracker_revision/modal/expenses_structure.dart';
import 'package:flutter/material.dart';

class ExpenseListhp extends StatelessWidget {
  const ExpenseListhp(this.storedExpStructure, this.onRemoveItem, {super.key});
  final List<ExpensesStructure> storedExpStructure;
  final void Function(ExpensesStructure expenseIndex) onRemoveItem;
  @override
  Widget build(context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: storedExpStructure.length,
      itemBuilder:
          (context, index) => Dismissible(
            background: Container(
              color: Theme.of(
                context,
              ).colorScheme.error.withValues(alpha: 0.75),
            ),
            key: ValueKey(storedExpStructure[index]),
            onDismissed: (direction) => onRemoveItem(storedExpStructure[index]),
            child: ExpenseListItem(storedExpStructure[index]),
          ),
    );
  }
}
