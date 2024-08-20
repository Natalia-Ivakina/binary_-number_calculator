import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:binary_calc_app/screens/about.dart';
import 'package:binary_calc_app/utils/animation.dart';
import 'package:binary_calc_app/providers/settigns_model.dart';
import 'package:binary_calc_app/utils/color_palette.dart';
import 'package:binary_calc_app/utils/vibration.dart';

//link to PP
final Uri _url = Uri.parse(
    'https://www.paypal.com/donate/?business=CAE3APFSM4DNQ&no_recurring=1&item_name=Thank+you%21&currency_code=CAD');

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Access SettingsModel through Provider
        final settings = Provider.of<SettingsModel>(context);
        double drawerWidth = MediaQuery.of(context).size.width;
        if (drawerWidth > settings.maxWidth) {
          drawerWidth = settings.maxWidth; // Максимальная ширина для мобильных
        }
        double drawerHeight = MediaQuery.of(context).size.height;
        if (drawerHeight > settings.maxHeight) {
          drawerHeight =
              settings.maxHeight; // Максимальная высота для мобильных
        }

        return Drawer(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Consumer<SettingsModel>(
            builder: (context, settings, child) {
              return Column(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    child: Row(
                      children: [
                        const RotatingImage(
                          imagePath: 'assets/splash.png',
                        ),
                        SizedBox(
                            width: drawerWidth == settings.maxWidth
                                ? 0
                                : drawerWidth * 0.09),
                        Text(
                          'Hello!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: colorPalette.map((color) {
                        bool isSelected = color == settings.currentColor;
                        int themeIndex = colorPalette.indexOf(color);
                        return GestureDetector(
                          onTap: () async {
                            await handleVibration(settings.isVibrationOn);
                            settings.updateTheme(themeIndex);
                            settings.updateColor(color);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? Colors.grey.shade500
                                  : Colors.transparent,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(drawerWidth * 0.007),
                              child: Icon(
                                Icons.color_lens,
                                color: color,
                                size: drawerWidth * 0.12,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.vibration,
                      size: drawerWidth * 0.08,
                      color:
                          Theme.of(context).colorScheme.onSecondaryFixedVariant,
                    ),
                    title: Text(
                      settings.isVibrationOn ? 'Vibration On' : 'Vibration Off',
                      style: TextStyle(
                        fontSize: 24,
                        color: settings.isVibrationOn
                            ? const Color.fromARGB(255, 16, 172, 123)
                            : Theme.of(context)
                                .colorScheme
                                .onSecondaryFixedVariant,
                      ),
                    ),
                    onTap: () {
                      settings.toggleVibration();
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.help,
                      size: drawerWidth * 0.08,
                      color:
                          Theme.of(context).colorScheme.onSecondaryFixedVariant,
                    ),
                    title: Text(
                      'About',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryFixedVariant,
                                fontSize: 24,
                              ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        CustomPageRoute(const About()),
                      );
                    },
                  ),
                  Divider(
                    color:
                        Theme.of(context).colorScheme.onSecondaryFixedVariant,
                    thickness: 2,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "The app is completely free, but if you'd like to say thank you, I've left the option to buy me a cup of coffee.",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryFixedVariant,
                                fontSize: 12,
                              ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.coffee,
                      size: drawerWidth * 0.08,
                      color:
                          Theme.of(context).colorScheme.onSecondaryFixedVariant,
                    ),
                    title: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.outline,
                        shadowColor: Colors.black,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                      ),
                      onPressed: _launchUrl,
                      child: SizedBox(
                        width: drawerWidth * 0.5,
                        child: Image.asset('assets/PP.png', fit: BoxFit.cover),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
