import 'package:expense_tracker_revision/modal/expenses_structure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class InsideOverlay extends StatefulWidget {
  const InsideOverlay({required this.listOfExpense, super.key});
  final void Function(ExpensesStructure expensesStructure) listOfExpense;
  @override
  State<InsideOverlay> createState() {
    return _InsideOverlayState();
  }
}

class _InsideOverlayState extends State<InsideOverlay> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedCategory = Category.leisure;

  void addingNewExpenses() {
    final doubleAmt = double.tryParse(_amountController.text);
    widget.listOfExpense(
      ExpensesStructure(
        name: _titleController.text,
        amount: doubleAmt!,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  void _showExceptionAndAddExpense() {
    final platform = Theme.of(context).platform == TargetPlatform.iOS;
    final platformBrightness =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final doubleAmt = double.tryParse(_amountController.text);
    if (_titleController.text.isEmpty ||
        doubleAmt == null ||
        doubleAmt <= 0 ||
        _selectedDate == null) {
      platform
          ? showCupertinoDialog(
            context: context,
            builder:
                (ctx) => CupertinoAlertDialog(
                  title: Text(
                    "INVALID INPUT",
                    style: TextStyle(color: Colors.brown.shade800),
                  ),
                  content: Text(
                    "Please fill your expense details.",
                    style:
                        platformBrightness
                            ? TextStyle(color: Colors.brown.shade800)
                            : Theme.of(context).textTheme.titleSmall,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text("Okay"),
                    ),
                  ],
                ),
          )
          : showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: Text(
                    "INVALID INPUT",
                    style: TextStyle(color: Colors.brown.shade800),
                  ),
                  content: Text(
                    "Please fill your expense details.",
                    style:
                        platformBrightness
                            ? TextStyle(color: Colors.brown.shade800)
                            : Theme.of(context).textTheme.titleSmall,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Okay"),
                    ),
                  ],
                ),
          );
      return;
    } else {
      addingNewExpenses();
    }
  }

  DateTime? _selectedDate;
  void _datepicker() async {
    final now = DateTime.now();
    final startdate = DateTime(now.year - 1, now.month, now.day);
    final _pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: startdate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = _pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final placingWidgetsForKeyboard = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                10,
                26,
                10,
                placingWidgetsForKeyboard + 10,
              ),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            keyboardType: TextInputType.emailAddress,
                            maxLength: 100,
                            decoration: InputDecoration(
                              counterStyle:
                                  isDarkMode
                                      ? const TextStyle(color: Colors.white)
                                      : Theme.of(context).textTheme.titleSmall,
                              label: Text(
                                "Title",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixText: "₹",
                              label: Text(
                                "Amount",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 100,
                      decoration: InputDecoration(
                        counterStyle:
                            isDarkMode
                                ? const TextStyle(color: Colors.white)
                                : Theme.of(context).textTheme.titleSmall,
                        label: Text(
                          "Title",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value:
                              _selectedCategory, //this is the value, that will appear on the drop down button, it's also changed when we choose one.
                          items:
                              Category.values.map((category) {
                                return DropdownMenuItem(
                                  value:
                                      category, //this value defines the selection, and this value is passed to onchanged.
                                  child: Text(category.name.toUpperCase()),
                                );
                              }).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              //update the UI after selection.
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const Spacer(),
                        Text(
                          _selectedDate == null
                              ? "No date picked"
                              : formatter.format(_selectedDate!),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        IconButton(
                          onPressed: _datepicker,
                          icon: const Icon(Icons.calendar_month_rounded),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixText: "₹",
                              label: Text(
                                "Amount",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          _selectedDate == null
                              ? "No date picked"
                              : formatter.format(_selectedDate!),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        IconButton(
                          onPressed: _datepicker,
                          icon: const Icon(Icons.calendar_month_rounded),
                        ),
                      ],
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _showExceptionAndAddExpense();

                            print(_titleController.text);
                            print(_amountController.text);
                            print(_selectedDate);
                          },
                          child: const Text("Save Changes"),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          value:
                              _selectedCategory, //this is the value, that will appear on the drop down button, it's also changed when we choose one.
                          items:
                              Category.values.map((category) {
                                return DropdownMenuItem(
                                  value:
                                      category, //this value defines the selection, and this value is passed to onchanged.
                                  child: Text(category.name.toUpperCase()),
                                );
                              }).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              //update the UI after selection.
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _showExceptionAndAddExpense();

                            print(_titleController.text);
                            print(_amountController.text);
                            print(_selectedDate);
                          },
                          child: const Text("Save Changes"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
