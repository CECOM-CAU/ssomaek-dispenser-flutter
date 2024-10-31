import 'package:flutter/material.dart';

class ExtractButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ExtractButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('토출하기'),
    );
  }
}
