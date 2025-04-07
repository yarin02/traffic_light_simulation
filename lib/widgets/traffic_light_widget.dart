import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/consts.dart';
import '../models/traffic_light.dart';
import '../providers/global_timer.dart';

/// A stateless widget that displays a traffic light based on the global timer.
class TrafficLightWidget extends StatelessWidget {
  final bool isSync;
  final int index;

  const TrafficLightWidget({
    Key? key,
    required this.isSync,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final elapsed = context.watch<GlobalTimerProvider>().elapsed;
    final currentState = _getCurrentState(elapsed);

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLight(
            isOn:
                currentState == TrafficLightState.red ||
                currentState == TrafficLightState.redYellow,
            color: kRedLightColor,
          ),
          _buildLight(
            isOn:
                currentState == TrafficLightState.yellow ||
                currentState == TrafficLightState.redYellow,
            color: kYellowLightColor,
          ),
          _buildLight(
            isOn: currentState == TrafficLightState.green,
            color: kGreenLightColor,
          ),
        ],
      ),
    );
  }

  /// Computes the current state of the traffic light based on the elapsed time.
  TrafficLightState _getCurrentState(Duration elapsed) {
    if (isSync) {
      // Sync mode: use the elapsed time directly.
      return TrafficLight.stateForTime(elapsed);
    } else {
      // Chaos mode: apply a random delay per widget.
      final delay = _computeDelay();
      if (elapsed < delay) {
        return TrafficLightState.red;
      } else {
        return TrafficLight.stateForTime(elapsed - delay);
      }
    }
  }

  /// Computes a random delay (up to 5000ms) based on the widget's index.
  Duration _computeDelay() {
    final random = Random(index);
    final ms = random.nextInt(5000);
    return Duration(milliseconds: ms);
  }

  Widget _buildLight({required bool isOn, required Color color}) {
    return SizedBox(
      width: kTrafficLightCircleSize,
      height: kTrafficLightCircleSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isOn ? color : kOffLightColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
        ),
      ),
    );
  }
}
