// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:imc_calculator/model/imc_model.dart';
import 'package:imc_calculator/repository/imc_repository.dart';
import 'package:imc_calculator/widgets/imc_card.dart';

class DialogsUtil {
  static void showListaImcs(
    BuildContext context,
    List<ImcModel> imcs,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actionsPadding: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            title: const Text(
              "LISTA DE IMC NÃO PERSISTENTE",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            content: imcs.isEmpty
                ? const Text(
                    "Nenhum IMC foi calculado ainda 🙄",
                    textAlign: TextAlign.center,
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
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
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Fechar",
                    style: TextStyle(fontSize: 16),
                  )),
            ],
          );
        });
  }

  static void showAvisoApagar(
    BuildContext context,
    Function() onPressed,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // actionsPadding: const EdgeInsets.all(8.0),
            actionsAlignment: MainAxisAlignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            title: const Text(
              "AVISO",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            content: Container(
              alignment: Alignment.center,
              // color: Colors.blue,
              height: MediaQuery.of(context).size.height * 0.2,
              child: const Text(
                "Voce deseja apagar a lista de IMC ? 🙄",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w300),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Fechar",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: onPressed,
                child: const Text(
                  "Apagar",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          );
        });
  }
}
