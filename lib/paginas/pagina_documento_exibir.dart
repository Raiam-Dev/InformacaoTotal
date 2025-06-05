import 'package:app_biblioteca/cores/cores_globais.dart';
import 'package:flutter/material.dart';
import 'package:app_biblioteca/servico/clound_firebase_servico.dart';

class PaginaDocumento extends StatefulWidget {
  final String texto;
  final String title;
  final String id;
  const PaginaDocumento({
    required this.texto,
    required this.title,
    required this.id,
    super.key,
  });

  @override
  State<PaginaDocumento> createState() => _PaginaDocumentoState();
}

class _PaginaDocumentoState extends State<PaginaDocumento> {
  final CloundFirebaseServico dataBase = CloundFirebaseServico();
  bool editar = false;
  late final TextEditingController _controllerEditar;
  @override
  void initState() {
    _controllerEditar = TextEditingController(text: widget.texto);
    super.initState();
  }

  void atualizarDocumento(docId, data, context) async {
    try {
      await dataBase.atualizarDocumento(docId, data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text('Atualizado com Sucesso'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (erro) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text('Erro'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPadrao,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Documento', style: TextStyle(color: Colors.white)),
        backgroundColor: corPadrao,
        actions: [
          editar == false
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      editar = true;
                    });
                  },
                  icon: Icon(Icons.edit),
                )
              : Text(''),
        ],
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: editar == false
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      SelectableText(
                        widget.texto,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controllerEditar,
                        expands: true,
                        maxLines: null,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: editar == true
          ? FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                atualizarDocumento(widget.id, {
                  'texto': _controllerEditar.text,
                }, context);
                setState(() {
                  editar = !editar;
                });
              },
              child: Icon(Icons.save_outlined, color: Colors.white),
            )
          : null,
    );
  }
}
