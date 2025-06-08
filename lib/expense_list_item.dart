import 'package:expense_tracker_revision/modal/expenses_structure.dart';
import 'package:flutter/material.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem(this.storedExpProperties, {super.key});
  final ExpensesStructure storedExpProperties;
  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              storedExpProperties.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              children: [
                Text(
                  "₹${storedExpProperties.amount.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                Icon(CategoryIcons[storedExpProperties.category]),
                SizedBox(width: 6),
                Text(
                  storedExpProperties.formattedDate().toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
