import 'package:expense_tracker_revision/charts/chart_layout.dart';
import 'package:expense_tracker_revision/expense_list_hp.dart';
import 'package:expense_tracker_revision/screens_ui/inside_overlay.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_revision/modal/expenses_structure.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  final List<ExpensesStructure> _storedExpStructure = [
    ExpensesStructure(
      name: "First expense",
      amount: 20.00,
      date: DateTime.now(),
      category: Category.food,
    ),
    ExpensesStructure(
      name: "second expense ",
      amount: 39.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  void addExpenseInList(ExpensesStructure expensesStructure) {
    setState(() {
      _storedExpStructure.add(expensesStructure);
    });
  }

  void removeExpenseFromList(ExpensesStructure expensesStructure) {
    final expenseIndex = _storedExpStructure.indexOf(expensesStructure);
    setState(() {
      _storedExpStructure.remove(expensesStructure);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expense removed"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _storedExpStructure.insert(expenseIndex, expensesStructure);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;

    Widget MainContent = Center(
      child: Text("No items present here, please add some."),
    );
    if (_storedExpStructure.isNotEmpty) {
      MainContent = ExpenseListhp(_storedExpStructure, removeExpenseFromList);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
          width >= 600
              ? Row(
                children: [
                  Expanded(
                    child: ChartLayout(registeredExpenses: _storedExpStructure),
                  ),
                  Expanded(child: MainContent),
                ],
              )
              : Column(
                children: [
                  ChartLayout(registeredExpenses: _storedExpStructure),
                  SizedBox(height: 20),
                  Expanded(child: MainContent),
                ],
              ),
      appBar: AppBar(
        centerTitle: true,
        //backgroundColor: const Color.fromARGB(255, 188, 170, 164),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.person_2_rounded),
        ),
        title: Text(
          "EXPENSE TRACKER",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder:
                    (context) => InsideOverlay(listOfExpense: addExpenseInList),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
