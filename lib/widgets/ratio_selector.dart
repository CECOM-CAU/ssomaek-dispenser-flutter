import 'package:flutter/material.dart';

class RatioSelector extends StatelessWidget {
  final int selectedRatio;
  final double sliderValue;
  final ValueChanged<int?> onRatioSelected;
  final ValueChanged<double> onSliderChanged;

  const RatioSelector({
    Key? key,
    required this.selectedRatio,
    required this.sliderValue,
    required this.onRatioSelected,
    required this.onSliderChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio<int?>(
              value: 0,
              groupValue: selectedRatio,
              onChanged: onRatioSelected,
            ),
            Radio<int?>(
              value: 1,
              groupValue: selectedRatio,
              onChanged: onRatioSelected,
            ),
            Radio<int?>(
              value: 2,
              groupValue: selectedRatio,
              onChanged: onRatioSelected,
            ),
          ],
        ),
        if (selectedRatio == 0)
          Slider(
            value: sliderValue,
            onChanged: onSliderChanged,
          ),
      ],
    );
  }
}
