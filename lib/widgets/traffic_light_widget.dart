import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../core/consts.dart';
import '../models/traffic_light.dart';

class TrafficLightWidget extends StatefulWidget {
  final bool isSync;

  const TrafficLightWidget({Key? key, required this.isSync}) : super(key: key);

  @override
  State<TrafficLightWidget> createState() => _TrafficLightWidgetState();
}

class _TrafficLightWidgetState extends State<TrafficLightWidget> {
  final TrafficLight _light = TrafficLight();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  @override
  void didUpdateWidget(TrafficLightWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isSync != widget.isSync) {
      // Reset the traffic light and restart the timer when mode changes
      _resetLight();
      _initializeTimer();
    }
  }

  // Initialize the timer based on current mode
  void _initializeTimer() {
    widget.isSync ? _startLoop() : _startAfterRandomDelay();
  }

  // Reset the light state and cancel existing timer
  void _resetLight() {
    _timer?.cancel();
    setState(() {
      _light.currentState = TrafficLightState.red;
    });
  }

  // Start after a random delay (chaos mode)
  void _startAfterRandomDelay() async {
    final delay = Duration(milliseconds: Random().nextInt(5000));
    await Future.delayed(delay);
    if (mounted) _startLoop();
  }

  // Start the regular state change loop
  void _startLoop() {
    _timer = Timer(_light.currentDuration, () {
      if (!mounted) return;
      setState(() {
        _light.nextState();
        _timer?.cancel();
        _startLoop();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentState = _light.currentState;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLight(
            isOn: currentState == TrafficLightState.red ||
                currentState == TrafficLightState.redYellow,
            color: kRedLightColor,
          ),
          _buildLight(
            isOn: currentState == TrafficLightState.yellow ||
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