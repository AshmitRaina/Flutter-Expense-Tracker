import 'package:flutter/material.dart';

class ChartBars extends StatefulWidget {
   const ChartBars({super.key, required this.fill});
  final double fill;

  @override
  State<ChartBars> createState() => _ChartBarsState();
}

class _ChartBarsState extends State<ChartBars> {
      
  @override
  Widget build(BuildContext context) {
final isDarkMode =MediaQuery.of(context).platformBrightness==Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FractionallySizedBox(
          heightFactor: widget.fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
              color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
