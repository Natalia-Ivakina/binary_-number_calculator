import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:binary_calc_app/providers/settigns_model.dart';

class About extends StatelessWidget {
  const About({super.key});

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'About Binary Cat ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 20.0,
                color: Color.fromARGB(255, 16, 175, 98),
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(' 01 10'),
                  WavyAnimatedText(' 00 01'),
                ],
                isRepeatingAnimation: true,
                onTap: () {},
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context)
              .colorScheme
              .onSurface, // Color of the menu icons
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenWidth,
            maxHeight: screenHeight,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Core Idea:',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      const SizedBox(width: 10),
                      // Spacing between text and image
                      Image.asset(
                        'assets/splash.png', // Use the provided image path
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                      'I created Binary Cat to help students work with binary numbers.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.secondary)),
                  const SizedBox(height: 16),
                  Text(
                    'Main Features:',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  _buildFeatureList(context),
                  const SizedBox(height: 16),
                  Text(
                    'Why the Cat?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Because cats make everything better.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                          softWrap: true, // Allows text to wrap to a new line
                        ),
                      ),
                      Image.asset(
                        'assets/cp0.png', // Use the provided image path
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.width * 0.15,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Technologies:',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Binary Cat is developed using Flutter and Dart for Android devices.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Big thanks:',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align to the left
                    children: [
                      Text(
                        'To my husband for his help and his nerdiness!',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'To my users for feedback and support!',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Developer:',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              )),
                      const SizedBox(width: 10),
                      Text(
                        'Natalia Ivakina',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureList(BuildContext context) {
    final features = [
      'Conversion between binary and decimal systems,',
      'Arithmetic operations on binary numbers,',
      'Easy color scheme customization.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features
          .map((feature) => Text(
                '• $feature',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ))
          .toList(),
    );
  }
}
