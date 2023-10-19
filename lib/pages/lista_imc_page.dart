import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imc_calculator/model/imc_model.dart';
import 'package:imc_calculator/repository/imc_repository.dart';
import 'package:imc_calculator/utils/dialogs_util.dart';
import 'package:imc_calculator/utils/snack_bar_util.dart';
import 'package:imc_calculator/widgets/imc_card.dart';

class ListaImcPage extends StatefulWidget {
  const ListaImcPage({
    super.key,
  });

  @override
  State<ListaImcPage> createState() => _ListaImcPageState();
}

class _ListaImcPageState extends State<ListaImcPage> {
  final ImcRepository _repository = ImcRepository();
  List<ImcModel> imcs = [];
  bool carregando = true;

  Future<void> _carregarValores() async {
    setState(() {
      carregando = true;
    });

    final list = await _repository.getAll();
    for (var imc in list) {
      imcs.add(imc);
    }

    setState(() {
      carregando = false;
    });
  }

  Future<void> _removerValores() async {
    await _repository.deleteAll();
  }

  Future<void> _apagarLista() async {
    setState(() {
      carregando = true;
    });
    if (imcs.isNotEmpty) {
      _removerValores();
      Navigator.pop(context);
      setState(() {
        imcs = [];
      });
      SnackBarUtil.infoSnackBar(context, "Lista de IMC apagada com sucesso");
    } else {
      SnackBarUtil.infoSnackBar(
          context, "Erro ao tentar deletar uma lista vazia");
      Navigator.pop(context);
    }
    setState(() {
      carregando = false;
    });
  }

  Widget pageBody() {
    if (imcs.isNotEmpty) {
      return ListView(
        scrollDirection: Axis.vertical,
        children: [
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
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
        ],
      );
    }
    return const Center(
      child: Text(
        'Nenhum IMC armazenado 😳',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
        textAlign: TextAlign.center,
      ),
    );
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
        title: const Text("Lista de IMC"),
        actions: [
          IconButton(
              onPressed: () {
                DialogsUtil.showAvisoApagar(
                  context,
                  _apagarLista,
                );
              },
              icon: const Icon(Icons.delete_rounded))
        ],
      ),
      body: carregando
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : pageBody(),
    );
  }
}
