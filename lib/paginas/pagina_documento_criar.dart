import 'package:app_biblioteca/servico/clound_firebase_servico.dart';
import 'package:app_biblioteca/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';

class PaginaCriarDocumento extends StatefulWidget {
  const PaginaCriarDocumento({super.key});

  @override
  State<PaginaCriarDocumento> createState() => _PaginaCriarDocumentoState();
}

class _PaginaCriarDocumentoState extends State<PaginaCriarDocumento> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerImagem = TextEditingController();
  final TextEditingController _controllerTexto = TextEditingController();
  final TextEditingController _controllerSubtitulo = TextEditingController();
  final CloundFirebaseServico dataBase = CloundFirebaseServico();

  void salvarDocumento(Map<String, dynamic> documento) async {
    try {
      await dataBase.criarDocumento(documento);
    } catch (erro) {
      print(erro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          MenuLateral(
            width: MediaQuery.of(context).size.width * 0.30,
            children: [
              SizedBox(height: 20),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Card(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Documento modelo = Documento(
                                _controllerImagem.text,
                                _controllerTitle.text,
                                _controllerSubtitulo.text,
                                _controllerTexto.text,
                              );
                              Map<String, dynamic> mapa = {
                                'title': modelo.title,
                                'subititulo': modelo.subtitulo,
                                'imagem': modelo.imagem,
                                'texto': modelo.texto,
                              };
                              salvarDocumento(mapa);
                            },
                            icon: Icon(Icons.save),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'TITULO',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _controllerTitle,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'SUBITITULO',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _controllerSubtitulo,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'IMAGEM DE CAPA',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _controllerImagem,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.70,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                child: TextField(
                  controller: _controllerTexto,
                  expands: true,
                  maxLines: null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Documento {
  String title;
  String subtitulo;
  String imagem;
  String texto;
  Documento(this.imagem, this.title, this.subtitulo, this.texto);
}
