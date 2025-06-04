import 'package:app_biblioteca/cores/cores_globais.dart';
import 'package:flutter/material.dart';
import 'package:app_biblioteca/servico/clound_firebase_servico.dart';
import 'package:app_biblioteca/widgets/menu_lateral.dart';

class PaginaDocumento extends StatefulWidget {
  final String texto;
  final String title;
  const PaginaDocumento({required this.texto, required this.title, super.key});

  @override
  State<PaginaDocumento> createState() => _PaginaDocumentoState();
}

class _PaginaDocumentoState extends State<PaginaDocumento> {
  final CloundFirebaseServico dataBase = CloundFirebaseServico();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPadrao,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Documento', style: TextStyle(color: Colors.white)),
        backgroundColor: corPadrao,
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.texto,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
