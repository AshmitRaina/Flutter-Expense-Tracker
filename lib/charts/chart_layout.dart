import 'package:expense_tracker_revision/charts/chart_bars.dart';
import 'package:expense_tracker_revision/modal/expenses_structure.dart';
import 'package:flutter/material.dart';

class ChartLayout extends StatelessWidget {
  ChartLayout({super.key, required this.registeredExpenses});
  final List<ExpensesStructure> registeredExpenses;
  List<chartStructure> get buckets {
    return [
      chartStructure.forCategory(
        allExpenses: registeredExpenses,
        category: Category.food,
      ),
      chartStructure.forCategory(
        allExpenses: registeredExpenses,
        category: Category.travel,
      ),
      chartStructure.forCategory(
        allExpenses: registeredExpenses,
        category: Category.leisure,
      ),
      chartStructure.forCategory(
        allExpenses: registeredExpenses,
        category: Category.grocery,
      ),
    ];
  }

  double get checkMaxofAllBuckets {
    double maxOfAllBuckets = 0;
    for (final bucket in buckets) {
      if (bucket.totalSumofExpense > maxOfAllBuckets)
        maxOfAllBuckets = bucket.totalSumofExpense;
    }
    return maxOfAllBuckets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          //Row to show the bars
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  ChartBars(
                    fill:
                        bucket.totalSumofExpense == 0
                            ? 0
                            : bucket.totalSumofExpense / checkMaxofAllBuckets,
                  ),
              ],
            ),
          ),
          SizedBox(height: 12,),
          //Row to show the icons below the bars
          Row(
            children:
                buckets
                    .map(
                      (bucket) => Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 33.0),
                          child: Icon(CategoryIcons[bucket.category]),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
