import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:binary_calc_app/providers/settigns_model.dart';

class OvalElevatedButton extends StatelessWidget {
  const OvalElevatedButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  final String text;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Access SettingsModel through Provider
    final settings = Provider.of<SettingsModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > settings.maxWidth) {
      screenWidth = settings.maxWidth; // Максимальная ширина для мобильных
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Set border radius
          ),
          elevation: 5,
          backgroundColor: color, // Set button color
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
    );
  }
}

//_____________________________________________________________________________
class RoundElevatedButton extends StatelessWidget {
  const RoundElevatedButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  final String text;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Access SettingsModel through Provider
    final settings = Provider.of<SettingsModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > settings.maxWidth) {
      screenWidth = settings.maxWidth; // Максимальная ширина для мобильных
    }

    return Padding(
      padding: const EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          elevation: 5,
          backgroundColor: color,
          // Set button color
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
    );
  }
}

//_____________________________________________________________________________
class SquareElevatedButton extends StatelessWidget {
  const SquareElevatedButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  final String text;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Access SettingsModel through Provider
    final settings = Provider.of<SettingsModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > settings.maxWidth) {
      screenWidth = settings.maxWidth; // Максимальная ширина для мобильных
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ElevatedButton(
        //iconAlignment: IconAlignment.start,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          backgroundColor: color,
          // Set button color
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
      ),
    );
  }
}
