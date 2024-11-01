import 'package:flutter/material.dart';

class DrinkButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DrinkButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('마셔마셔'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 20),
      ),
    );
  }
}
