// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';


import 'package:imc_calculator/utils/imc_formula.dart' as imc_formula;

void main() {
  testWidgets('Testando Valores de entrada e Saidas para o Calculo IMC',
      (WidgetTester tester) async {
    imc_formula.ImcFormula imc = imc_formula.ImcFormula();

    // expect(imc.resultadoIMC(imc: 26.72, altura: 0, peso: 0),
    //     'IMC: 26.72 / ${ImcClassificacoesConstants.sobrepeso}');

    // expect(imc.resultadoIMC(altura: 1.73, peso: 80), 'IMC: 26.729927495071667 / ${ImcClassificacoesConstants.sobrepeso}');

  });
}
