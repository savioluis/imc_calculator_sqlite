import 'package:flutter/material.dart';
import 'package:imc_calculator/model/imc_model.dart';
import 'package:imc_calculator/services/shared_preferences_service.dart';
import 'package:imc_calculator/widgets/imc_card.dart';

class DialogsUtil {
  static void showListOfImcs(
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
              "LISTA DE IMC TEMPORARIA",
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
}
