import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imc_calculator/pages/calculadora_imc_page.dart';
import 'package:imc_calculator/widgets/custom_large_button_widget.dart';
import 'package:imc_calculator/widgets/custom_text_field_widget.dart';
import 'package:imc_calculator/services/shared_preferences_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool carregando = true;

  final nomeController = TextEditingController();
  final alturaController = TextEditingController();
  final _formField = GlobalKey<FormState>();

  void _formValidate() async {
    if (_formField.currentState!.validate()) {
      await SharedPreferencesService.setNome(nomeController.value.text.trim());
      await SharedPreferencesService.setAltura(
        double.parse(alturaController.value.text.trim()),
      );
      _navigateToCalculatorPage();
    }
  }

  void _navigateToCalculatorPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CalculadoraIMCPage()),
    );
  }

  Future<void> _preencherCampos() async {
    setState(() {
      carregando = true;
    });
    if (await SharedPreferencesService.getNome() != null &&
        await SharedPreferencesService.getNome() != "") {
      nomeController.text = '${await SharedPreferencesService.getNome()}';
    }
    if (await SharedPreferencesService.getAltura() != null &&
        await SharedPreferencesService.getAltura() != -1) {
      alturaController.text = '${await SharedPreferencesService.getAltura()}';
    }
    setState(() {
      carregando = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _preencherCampos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 96),
                child: Form(
                  key: _formField,
                  child: Column(
                    children: [
                      const Divider(height: 0, thickness: 1.5),
                      Text(
                        "IMC CALCULATOR",
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            color: Colors.blue[300]),
                        textAlign: TextAlign.center,
                      ),
                      const Divider(height: 0, thickness: 1.5),
                      const SizedBox(height: 32),
                      const FlutterLogo(size: 96),
                      const SizedBox(height: 32),
                      CustomTextField(
                        textController: nomeController,
                        textFieldType: TextFieldType.nome,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        textController: alturaController,
                        textFieldType: TextFieldType.altura,
                      ),
                      const SizedBox(height: 32),
                      CustomLargeButton(
                        text: 'Continuar',
                        onPressed: _formValidate,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
