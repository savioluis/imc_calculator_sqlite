import 'package:flutter/material.dart';
import 'package:imc_calculator/pages/lista_imc_page.dart';
import 'package:imc_calculator/pages/meu_perfil_page.dart';
import 'package:imc_calculator/utils/dialogs_util.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.nome,
    required this.altura,
  });

  final String nome;
  final double altura;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                'Altura: $altura m',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            accountName: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                nome,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            currentAccountPicture: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MeuPerfilPage(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.black87,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.account_box_rounded,
              color: Colors.black54,
            ),
            title: const Text('Meu Perfil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MeuPerfilPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.library_books,
              color: Colors.black54,
            ),
            title: const Text('Lista de IMC'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListaImcPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.info_outline_rounded,
              color: Colors.black54,
            ),
            title: const Text('Informacoes'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.black54,
            ),
            title: const Text('Configuracoes'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
