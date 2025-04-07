import '../core/consts.dart';

class TrafficLight {
  // Computes the current state based on an effective time (global time + offset)
  static TrafficLightState stateForTime(Duration effectiveTime) {
    // Compute total duration of one cycle.
    final cycleDuration = kTrafficLightDurations.values.reduce((a, b) => a + b);
    // Convert durations to milliseconds and calculate the remainder.
    final modMillis = effectiveTime.inMilliseconds % cycleDuration.inMilliseconds;
    final modTime = Duration(milliseconds: modMillis);
    Duration remaining = modTime;
    for (final state in TrafficLightState.values) {
      final stateDuration = kTrafficLightDurations[state]!;
      if (remaining < stateDuration) {
        return state;
      }
      remaining -= stateDuration;
    }
    return TrafficLightState.red; // Fallback (should never reach here)
  }
}
