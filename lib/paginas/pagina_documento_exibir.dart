import 'package:app_biblioteca/servico/clound_firebase_servico.dart';
import 'package:app_biblioteca/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';

class PaginaDocumento extends StatefulWidget {
  const PaginaDocumento({super.key});

  @override
  State<PaginaDocumento> createState() => _PaginaDocumentacaoState();
}

class _PaginaDocumentacaoState extends State<PaginaDocumento> {
  final CloundFirebaseServico dataBase = CloundFirebaseServico();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          MenuLateral(
            width: MediaQuery.of(context).size.width * 0.30,
            children: [],
          ),
        ],
      ),
    );
  }
}
