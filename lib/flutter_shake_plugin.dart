import 'dart:async';
import 'dart:math';

import 'package:sensors/sensors.dart';
import 'package:vibration/vibration.dart';

/// Callback for phone shakes
typedef Null PhoneShakeCallback();

class FlutterShakePlugin {
  /// callback for phone shake
  final PhoneShakeCallback onPhoneShaken;

  /// Minimum time between shake
  final int shakeTimeMS;

  /// Last shake time
  var _lastTime = 0;

  /// Shake detection threshold
  final double shakeThresholdGravity;

  /// if do vibration when phone shakes
  final bool shouldVibrate;

  /// vibration duration
  final int vibrateDuration;

  /// StreamSubscription for Accelerometer events
  StreamSubscription? streamSubscription;

  /// This constructor waits until [startListening] is called
  FlutterShakePlugin({
    required this.onPhoneShaken,
    this.shakeTimeMS = 500,
    this.shakeThresholdGravity = 3.25,
    this.shouldVibrate = true,
    this.vibrateDuration = 500,
  });

  /// Starts listening to accerelometer events
  void startListening() {
    streamSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      var now = DateTime.now().millisecondsSinceEpoch;
      if ((now - _lastTime) > shakeTimeMS) {
        double x = event.x;
        double y = event.y;
        double z = event.z;
        double acceleration = sqrt(x * x + y * y + z * z) - 9.8;
        if (acceleration > shakeThresholdGravity) {
          if (shouldVibrate) Vibration.vibrate(duration: vibrateDuration);
          _lastTime = now;
          onPhoneShaken();
        }
      }
    });
  }

  /// Stops listening to accelerometer events
  void stopListening() {
    streamSubscription?.cancel();
  }
}
