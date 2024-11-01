import 'package:flutter/material.dart';
import 'dart:async';

class MixingGauge extends StatefulWidget {
  final int counterA;
  final int counterB;

  const MixingGauge({
    Key? key,
    required this.counterA,
    required this.counterB,
  }) : super(key: key);

  @override
  State<MixingGauge> createState() => MixingGaugeState();
}
class MixingGaugeState extends State<MixingGauge> {
  double _currentHeight = 0.0;

  void setGaugeHeight(double height) {
    setState(() {
      _currentHeight = height;
    });
  }

  void reduceGauge() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        if (_currentHeight > 5) {
          _currentHeight -= 5; // 게이지 바가 줄어드는 속도 조정
        } else {
          _currentHeight = 0; // 음수로 내려가지 않도록 0으로 고정
          timer.cancel();
        }
      });
    });
  }


  void fillGauge(int counterA, int counterB) {
    setState(() {
      _currentHeight = (_currentHeight + ((counterA + counterB) * 2.0)).clamp(0, 200);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 100,
      color: Colors.grey[300],
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: _currentHeight,
            color: Colors.cyanAccent,
            child: const Center(
              child: Text('CECOM...'),
            ),
          ),
        ],
      ),
    );
  }
}
