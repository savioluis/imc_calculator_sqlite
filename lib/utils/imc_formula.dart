import 'package:imc_calculator/constants/imc_classificacoes_constants.dart';

class ImcFormula {

  static double calcularIMC(double peso, double altura) {
    return peso / (altura * altura);
  }

  static String resultadoIMC(double imc) {
    
    switch (imc) {
      case < 16:
        return ImcClassificacoesConstants.magrezaGrave;
      case >= 16 && < 17:
        return ImcClassificacoesConstants.magrezaModerada;
      case >= 17 && < 18.5:
        return ImcClassificacoesConstants.magrezaLeve;
      case >= 18.5 && < 25:
        return ImcClassificacoesConstants.saudavel;
      case >= 25 && < 30:
        return ImcClassificacoesConstants.sobrepeso;
      case >= 30 && < 35:
        return ImcClassificacoesConstants.obesidadeGrau1;
      case >= 35 && < 40:
        return ImcClassificacoesConstants.obesidadeGrau2;
      case >= 40:
        return ImcClassificacoesConstants.obesidadeGrau3;
      default:
        return "";
    }
  }

  
}
