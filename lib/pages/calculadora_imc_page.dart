import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imc_calculator/model/imc_model.dart';
import 'package:imc_calculator/repository/imc_repository.dart';
import 'package:imc_calculator/widgets/custom_large_button_widget.dart';
import 'package:imc_calculator/services/shared_preferences_service.dart';
import 'package:imc_calculator/utils/dialogs_util.dart';
import 'package:imc_calculator/utils/imc_formula.dart';
import 'package:imc_calculator/utils/snack_bar_util.dart';

import '../widgets/custom_drawer_widget.dart';
import '../widgets/custom_text_field_widget.dart';

class CalculadoraIMCPage extends StatefulWidget {
  const CalculadoraIMCPage({super.key});

  @override
  State<CalculadoraIMCPage> createState() => _CalculadoraIMCPageState();
}

class _CalculadoraIMCPageState extends State<CalculadoraIMCPage> {
  bool carregando = true;

  final _formfield = GlobalKey<FormState>();
  final TextEditingController pesoController = TextEditingController();

  String resultadoIMCTela = "";
  double valorIMCTela = -1;
  List<ImcModel> listaImcTemporaria = [];

  String nome = '';
  double altura = 0.0;

  final ImcRepository _repository = ImcRepository();

  Future<void> _carregarValores() async {
    setState(() {
      carregando = true;
    });
    if (await SharedPreferencesService.getNome() != null) {
      nome = '${await SharedPreferencesService.getNome()}';
    }
    if (await SharedPreferencesService.getAltura() != null) {
      altura = (await SharedPreferencesService.getAltura())!;
    }
    setState(() {
      carregando = false;
    });
  }

  Future<void> _salvarImcNoBanco(ImcModel imc) async {
    _repository.save(imc);
  }

  void _formValidate() async {
    if (_formfield.currentState!.validate()) {
      double peso = double.parse(pesoController.value.text);

      double valorIMC = ImcFormula.calcularIMC(peso, altura);
      String categoriaIMC = ImcFormula.resultadoIMC(valorIMC);

      int dbIndex = await _repository.getCount() ?? 0;

      ImcModel imc = ImcModel(
        id: dbIndex,
        valor: valorIMC,
        categoria: categoriaIMC,
        altura: altura,
        nome: nome,
        peso: peso,
      );

      _salvarImcNoBanco(imc);
      listaImcTemporaria.add(imc);

      setState(() {
        valorIMCTela = valorIMC;
        resultadoIMCTela = categoriaIMC;
      });

      print('peso: ${pesoController.value.text}');
      print(resultadoIMCTela);

      pesoController.clear();
      SnackBarUtil.infoSnackBar(context, "IMC calculado com sucesso");
    }
  }

  @override
  void initState() {
    _carregarValores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        altura: altura,
        nome: nome,
      ),
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
      ),
      floatingActionButton: carregando
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                DialogsUtil.showListaImcs(
                  context,
                  listaImcTemporaria,
                );
              },
              backgroundColor: Colors.blueAccent,
              child: const Icon(
                Icons.format_list_numbered_rounded,
              ),
            ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: MediaQuery.of(context).size.height * 0.25),
                child: Form(
                  key: _formfield,
                  child: Column(
                    children: [
                      CustomTextField(
                        textController: pesoController,
                        textFieldType: TextFieldType.peso,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomLargeButton(
                        text: 'Calcular IMC',
                        onPressed: _formValidate,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        valorIMCTela == -1 ? "" : "Resultado: ",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(resultadoIMCTela),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(valorIMCTela == -1 ? "" : "IMC: ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(valorIMCTela == -1
                                  ? ""
                                  : valorIMCTela.toStringAsFixed(2)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
