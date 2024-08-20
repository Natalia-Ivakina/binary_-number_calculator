import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:binary_calc_app/widgets/calculation.dart';
import 'package:binary_calc_app/widgets/convertation.dart';
import 'package:binary_calc_app/widgets/drawer.dart';
import 'package:binary_calc_app/providers/settigns_model.dart';
import 'package:binary_calc_app/utils/vibration.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({super.key});

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Access SettingsModel through Provider
    final settings = Provider.of<SettingsModel>(context);

    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > settings.maxWidth) {
      screenWidth = settings.maxWidth; // Максимальная ширина для мобильных
    }
    double screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight > settings.maxHeight) {
      screenHeight = settings.maxHeight; // Максимальная высота для мобильных
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              ' Binary Arithmetic ',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 20.0,
                color: Color.fromARGB(255, 16, 175, 98),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedTextKit(
                    totalRepeatCount: 1000,
                    pause: const Duration(milliseconds: 20000),
                    animatedTexts: [
                      WavyAnimatedText('0110'),
                      WavyAnimatedText('1001'),
                    ],
                    isRepeatingAnimation: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      drawer: const MainDrawer(),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.compare_arrows, title: 'Convert'),
          TabItem(icon: Icons.calculate, title: 'Calculate'),
        ],
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        onTap: (index) async {
          await handleVibration(settings.isVibrationOn); // Vibration on tap
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: Center(
        child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth,
              maxHeight: screenHeight,
            ),
            child: _currentIndex == 0
                ? const Convertation()
                : const Calculation()),
      ),
    );
  }
}
