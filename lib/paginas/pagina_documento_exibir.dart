import 'package:flutter/material.dart';
import 'package:app_biblioteca/servico/clound_firebase_servico.dart';
import 'package:app_biblioteca/widgets/menu_lateral.dart';

class PaginaDocumento extends StatefulWidget {
  final String texto;
  const PaginaDocumento({required this.texto, super.key});

  @override
  State<PaginaDocumento> createState() => _PaginaDocumentoState();
}

class _PaginaDocumentoState extends State<PaginaDocumento> {
  final CloundFirebaseServico dataBase = CloundFirebaseServico();

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Documento"),
        backgroundColor: Colors.redAccent,
      ),
      drawer: largura < 800
          ? Drawer(
              child: MenuLateral(width: largura * 0.25, children: const []),
            )
          : null,
      body: Row(
        children: [
          if (largura >= 800)
            MenuLateral(width: largura * 0.20, children: const []),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Text(
                  widget.texto,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
