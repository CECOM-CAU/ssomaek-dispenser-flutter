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

  @override
  void didUpdateWidget(MixingGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _currentHeight = (widget.counterA + widget.counterB) * 2.0;
    });
  }

  void reduceGauge() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        if (_currentHeight > 0) {
          _currentHeight -= 5;  // 게이지 바가 줄어드는 속도 조정
        } else {
          timer.cancel();
        }
      });
    });
  }

  void fillGauge(int counterA, int counterB) {
    setState(() {
      // counterA와 counterB의 합에 비례하여 게이지 높이를 설정하되, 최대값은 100으로 제한
      _currentHeight = ((counterA + counterB) * 2.0).clamp(0, 100);
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
            color: Colors.cyan,
            child: const Center(
              child: Text('CECOM...'),
            ),
          ),
        ],
      ),
    );
  }
}
