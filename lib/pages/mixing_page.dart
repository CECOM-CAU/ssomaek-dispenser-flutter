import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/counter_display.dart';
import '../widgets/ratio_selector.dart';
import '../widgets/mixing_gauge.dart';
import '../widgets/extract_button.dart';
import '../widgets/drink_button.dart';

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
  int totalA = 0; // A의 누적 토출량
  int totalB = 0; // B의 누적 토출량
  final Random random = Random(); // 랜덤 객체 생성
  final GlobalKey<MixingGaugeState> _mixingGaugeKey = GlobalKey<MixingGaugeState>();

  void updateCounters(int a, int b) {
    setState(() {
      counterA = a;
      counterB = b;
    });
  }

  void accumulateCounters() {
    totalA += counterA;
    totalB += counterB;
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: CounterDisplay(counterA: counterA, counterB: counterB),
          ),
          RatioSelector(
            selectedRatio: selectedRatio,
            sliderValue: sliderValue,
            onRatioSelected: (int? value) {
              setState(() {
                selectedRatio = value ?? 0;
                if (selectedRatio == 1) {
                  updateCounters(3, 7);
                } else if (selectedRatio == 2) {
                  int randomValueA = random.nextInt(25) + 5;
                  int randomValueB = random.nextInt(25) + 5;
                  updateCounters(randomValueA, randomValueB);
                } else {
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
          MixingGauge(
            key: _mixingGaugeKey,
            counterA: counterA,
            counterB: counterB,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ExtractButton(
                  onPressed: () {
                    _mixingGaugeKey.currentState?.reduceGauge();
                    setState(() {
                      updateCounters(0, 0);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('총 토출량'),
                            content: Text('A 토출량: $totalA ml\nB 토출량: $totalB ml'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    totalA = 0;
                                    totalB = 0;
                                  });
                                },
                                child: const Text('확인'),
                              ),
                            ],
                          );
                        },
                      );
                    });
                  },
                ),
                const SizedBox(height: 10),
                DrinkButton(
                  onPressed: () async {
                    accumulateCounters();
                    // 500ms 지연 후 fillGauge 호출
                    await Future.delayed(const Duration(milliseconds: 500));
                    _mixingGaugeKey.currentState?.fillGauge(counterA, counterB);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
