import 'package:flutter/material.dart';
import 'package:imc_calculator/model/imc_model.dart';
import 'package:imc_calculator/widgets/imc_card.dart';

class ListaImcPage extends StatefulWidget {
  const ListaImcPage({
    super.key,
  });

  @override
  State<ListaImcPage> createState() => _ListaImcPageState();
}

class _ListaImcPageState extends State<ListaImcPage> {
  bool carregando = true;

  ///TODO: fazer o codigo sqflite para pegar a lista de imc e construir nessa tela
  List<ImcModel> imcs = [
    ImcModel(valor: 2000, categoria: "Ofsa foasofsaioi", nome: 'Pedro', peso: 24, altura: 1.2)
  ];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de IMC"),
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                height: 120,
                child: ListView.separated(
                  itemCount: imcs.length,
                  itemBuilder: (context, index) {
                    return ImcCard(
                      imc: imcs[index],
                      index: index + 1,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                ),
              ),
            ),
    );
  }
}
