import 'package:app_biblioteca/cores/cores_globais.dart';
import 'package:app_biblioteca/servico/clound_firebase_servico.dart';
import 'package:app_biblioteca/widgets/app_bar_customisacao.dart';
import 'package:app_biblioteca/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';

class PaginaPainel extends StatefulWidget {
  const PaginaPainel({super.key});

  @override
  State<PaginaPainel> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaPainel> {
  CloundFirebaseServico database = CloundFirebaseServico();
  late DocumentoModelo documento = DocumentoModelo(
    title: '',
    texto: '',
    imagem: '',
  );
  bool carregando = false;

  Future<List<Map<String, dynamic>>> buscarUsuario() async {
    try {
      List<Map<String, dynamic>> mapa = await database.buscarDocumentos();
      return mapa;
    } catch (erro) {
      throw Exception(erro);
    }
  }

  late List<Map<String, dynamic>> dados = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPadrao,
      appBar: AppBarCustomisacao(),
      body: Row(
        children: [
          MenuLateral(
            width: MediaQuery.of(context).size.width * 0.30,
            children: [
              ElevatedButton(
                child: Text('Criar Documento'),
                onPressed: () =>
                    Navigator.pushNamed(context, 'PaginaCriarDocumento'),
              ),
              ElevatedButton(
                onPressed: () async {
                  dados = await buscarUsuario();
                  setState(() {});
                },
                child: Text('Buscar'),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: dados.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Image.network(dados[index]['imagem']),
                      Text(dados[index]['title']),
                      Text(dados[index]['subititulo']),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DocumentoModelo {
  String texto;
  String title;
  String imagem;
  DocumentoModelo({
    required this.title,
    required this.texto,
    required this.imagem,
  });
}
