import '../core/consts.dart';

class TrafficLight {
  TrafficLightState currentState = TrafficLightState.red;

  // Advances to the next traffic light state in the sequence
  void nextState() {
    final allStates = TrafficLightState.values;
    final currentIndex = allStates.indexOf(currentState);
    currentState = allStates[(currentIndex + 1) % allStates.length];
  }

  // Returns the duration that this state should last
  Duration get currentDuration => kTrafficLightDurations[currentState]!;
}