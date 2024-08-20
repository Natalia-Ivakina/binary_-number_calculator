import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:binary_calc_app/screens/data_screen.dart';
import 'package:binary_calc_app/providers/settigns_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final settings = SettingsModel();
  // loading settings
  await settings.loadPreferences();

  runApp(ChangeNotifierProvider<SettingsModel>.value(
    value: settings,
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: (context, settings, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Binary Cat',
          theme: settings.currentTheme, // theme
          home: const CalculationScreen(),
        );
      },
    );
  }
}
