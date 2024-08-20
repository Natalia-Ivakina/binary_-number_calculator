import 'package:vibration/vibration.dart';

Future<void> handleVibration(bool isVibrationOn) async {
  if (isVibrationOn) {
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
      Vibration.vibrate(duration: 5); // Vibration on tap
    }
  }
}
