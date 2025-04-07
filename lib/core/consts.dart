import 'package:flutter/material.dart';

// Traffic light configuration
const int kTrafficLightCount = 1000;
const double kTrafficLightCircleSize = 40.0;

// Traffic light colors
const Color kRedLightColor = Colors.red;
const Color kYellowLightColor = Colors.yellow;
const Color kGreenLightColor = Colors.green;
const Color kOffLightColor = Color(0xFFD3D3D3); // Light grey
const Color kBlueButton = Colors.blueAccent;
const Color kWhiteButtonText = Colors.white;


// Traffic light state durations
const Map<TrafficLightState, Duration> kTrafficLightDurations = {
  TrafficLightState.red: Duration(seconds: 3),
  TrafficLightState.redYellow: Duration(milliseconds: 1500),
  TrafficLightState.green: Duration(seconds: 3),
  TrafficLightState.yellow: Duration(milliseconds: 1500),
};

// Grid layout configuration
const int kGridCrossAxisCount = 5;
const double kGridMainAxisSpacing = 24.0;
const double kGridCrossAxisSpacing = 20.0;
const double kGridChildAspectRatio = 0.5;

// Traffic light states
enum TrafficLightState {
  red,
  redYellow,
  green,
  yellow,
}

// Padding and spacing
const EdgeInsets kDefaultPadding = EdgeInsets.all(12.0);
const EdgeInsets kVerticalPadding = EdgeInsets.symmetric(vertical: 12.0);