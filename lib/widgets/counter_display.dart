import 'package:flutter/material.dart';

class CounterDisplay extends StatelessWidget {
  final int counterA;
  final int counterB;

  const CounterDisplay({
    Key? key,
    required this.counterA,
    required this.counterB,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('A 토출량 $counterA ml', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 50)),
        Text('B 토출량 $counterB ml', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 50)),
      ],
    );
  }
}
