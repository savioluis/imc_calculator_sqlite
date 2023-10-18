import 'package:flutter/material.dart';
import 'package:imc_calculator/pages/home_page.dart';

import 'services/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  runApp(const ImcCalculatorApp());
}

class ImcCalculatorApp extends StatelessWidget {
  const ImcCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: false,
      ),
      home: HomePage(),
    );
  }
}
