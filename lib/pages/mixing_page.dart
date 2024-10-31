import 'package:flutter/material.dart';
import '../widgets/counter_display.dart';
import '../widgets/ratio_selector.dart';
import '../widgets/mixing_gauge.dart';
import '../widgets/extract_button.dart';

class MixingPage extends StatefulWidget {
  const MixingPage({super.key});

  @override
  State<MixingPage> createState() => _MixingPageState();
}

class _MixingPageState extends State<MixingPage> {
  int counterA = 0;
  int counterB = 0;
  int selectedRatio = 0;
  double sliderValue = 0.5;
  final GlobalKey<MixingGaugeState> _mixingGaugeKey = GlobalKey<MixingGaugeState>();

  void updateCounters(int a, int b) {
    setState(() {
      counterA = a;
      counterB = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CECOM Mixer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 상단에 CounterDisplay 추가
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: CounterDisplay(counterA: counterA, counterB: counterB),
          ),
          // 슬라이더와 비율 선택기
          RatioSelector(
            selectedRatio: selectedRatio,
            sliderValue: sliderValue,
            onRatioSelected: (int? value) {
              setState(() {
                selectedRatio = value ?? 0;
                if (selectedRatio == 1) {
                  updateCounters(3, 7);
                } else if (selectedRatio == 2) {
                  updateCounters(
                    (10 * sliderValue).round(),
                    10 - (10 * sliderValue).round(),
                  );
                }
              });
            },
            onSliderChanged: (value) {
              setState(() {
                sliderValue = value;
                updateCounters(
                  (10 * sliderValue).round(),
                  10 - (10 * sliderValue).round(),
                );
              });
            },
          ),
          // 게이지 바
          MixingGauge(
            key: _mixingGaugeKey,
            counterA: counterA,
            counterB: counterB,
          ),
          // 도출하기 버튼을 하단으로 이동
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ExtractButton(
                  onPressed: () {
                    _mixingGaugeKey.currentState?.reduceGauge();
                    setState(() {
                      updateCounters(0, 0);
                    });
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _mixingGaugeKey.currentState?.fillGauge(counterA, counterB);
                  },
                  child: const Text('마셔마셔'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
