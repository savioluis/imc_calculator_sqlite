// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imc_calculator/pages/calculadora_imc_page.dart';
import 'package:imc_calculator/widgets/custom_large_button_widget.dart';
import 'package:imc_calculator/services/shared_preferences_service.dart';
import 'package:imc_calculator/utils/snack_bar_util.dart';

import '../widgets/custom_text_field_widget.dart';

class MeuPerfilPage extends StatefulWidget {
  const MeuPerfilPage({super.key});

  @override
  State<MeuPerfilPage> createState() => _MeuPerfilPageState();
}

class _MeuPerfilPageState extends State<MeuPerfilPage> {
  final TextEditingController alturaController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final _formField = GlobalKey<FormState>();
  bool carregando = true;

  Future<void> _carregarValores() async {
    setState(() {
      carregando = true;
    });
    if (await SharedPreferencesService.getNome() != null) {
      nomeController.text = '${await SharedPreferencesService.getNome()}';
    }
    if (await SharedPreferencesService.getAltura() != null) {
      alturaController.text = '${await SharedPreferencesService.getAltura()}';
    }
    setState(() {
      carregando = false;
    });
  }

  Future<void> _salvarValores() async {
    setState(() {
      carregando = true;
    });
    SharedPreferencesService.setNome(nomeController.value.text.trim());
    SharedPreferencesService.setAltura(
        double.parse(alturaController.value.text.trim()));
    setState(() {
      carregando = false;
    });
  }

  Future<bool> alturaMudou() async {
    if (alturaController.value.text.trim() ==
        '${await SharedPreferencesService.getAltura()}') {
      return false;
    }
    return true;
  }

  Future<bool> nomeMudou() async {
    if (nomeController.value.text.trim() ==
        '${await SharedPreferencesService.getNome()}') {
      return false;
    }
    return true;
  }

  void _formValidate() async {
    if (_formField.currentState!.validate()) {
      if ((await alturaMudou() || await nomeMudou())) {
        _salvarValores();
        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CalculadoraIMCPage(),
            ));
        SnackBarUtil.infoSnackBar(
            context, "Os dados foram salvos com sucesso");
      } else {
        SnackBarUtil.infoSnackBar(
            context, "Realize alguma alteração para salvar os dados");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarValores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Perfil"),
      ),
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
                      CustomTextField(
                        textController: nomeController,
                        textFieldType: TextFieldType.nome,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        textController: alturaController,
                        textFieldType: TextFieldType.altura,
                      ),
                      const SizedBox(height: 24),
                      CustomLargeButton(
                        text: 'Salvar',
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
