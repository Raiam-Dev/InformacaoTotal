import 'package:app_biblioteca/cores/cores_globais.dart';
import 'package:app_biblioteca/paginas/pagina_shorts.dart';
import 'package:flutter/material.dart';
import 'package:app_biblioteca/paginas/pagina_documento_exibir.dart';
import 'package:app_biblioteca/servico/clound_firebase_servico.dart';
import 'package:app_biblioteca/widgets/app_bar_customisacao.dart';
import 'package:app_biblioteca/widgets/menu_lateral.dart';

class PaginaPainel extends StatefulWidget {
  const PaginaPainel({super.key});

  @override
  State<PaginaPainel> createState() => _PaginaPainelState();
}

class _PaginaPainelState extends State<PaginaPainel> {
  final CloundFirebaseServico database = CloundFirebaseServico();
  List<Map<String, dynamic>> documentos = [];
  bool carregando = true;
  int indexBottomNavigator = 0;

  @override
  void initState() {
    super.initState();
    _carregarDocumentos();
  }

  Future<void> _carregarDocumentos() async {
    setState(() => carregando = true);
    try {
      final resultado = await database.buscarDocumentos();
      setState(() {
        documentos = resultado;
      });
    } catch (_) {
      documentos = [];
    } finally {
      setState(() => carregando = false);
    }
  }

  int _calcularColunas(double largura) {
    if (largura > 1200) return 3;
    if (largura > 1000) return 3;
    if (largura > 800) return 2;
    if (largura > 600) return 1;
    return 1;
  }

  Widget _buildCard(Map<String, dynamic> doc, double cardHeight) {
    final imagemUrl = doc['imagem'];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                PaginaDocumento(texto: doc['texto'] ?? '', title: doc['title']),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
                child: Image.network(
                  imagemUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(100),
                    child: Image.network(
                      'https://static.vecteezy.com/system/resources/previews/016/133/305/non_2x/rk-logo-design-monogram-emblem-style-with-crown-shape-template-icon-vector.jpg',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doc['title'] ?? 'Sem título',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: 0.1,
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 4),
                      Text(
                        doc['subtitulo'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFAAAAAA),
                          letterSpacing: 0,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final colunas = _calcularColunas(largura);

    return Scaffold(
      backgroundColor: corPadrao,
      appBar: indexBottomNavigator == 0 ? AppBarCustomisacao() : null,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.60,
        shape: ContinuousRectangleBorder(),
        child: MenuLateral(
          children: [
            SizedBox(height: 40),
            GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(context, 'PaginaCriarDocumento');
                _carregarDocumentos();
              },
              child: ListTile(
                leading: Icon(Icons.note_add_rounded, color: Colors.white),
                title: Text(
                  'Criar Documento',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      body: indexBottomNavigator == 0
          ? Row(
              children: [
                if (largura >= 800)
                  MenuLateral(
                    children: [
                      SizedBox(height: 10),
                      Icon(Icons.home),
                      Text("Home"),
                    ],
                  ),
                Expanded(
                  child: carregando
                      ? const Center(child: CircularProgressIndicator())
                      : documentos.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhum documento encontrado.',
                            style: TextStyle(color: Colors.black54),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _carregarDocumentos,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: colunas,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 1,
                                    childAspectRatio: 1.2,
                                  ),
                              itemCount: documentos.length,
                              itemBuilder: (context, index) {
                                final doc = documentos[index];
                                return LayoutBuilder(
                                  builder: (context, constraints) {
                                    final cardHeight =
                                        constraints.maxWidth * 0.75;
                                    return _buildCard(doc, cardHeight);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                ),
              ],
            )
          : PaginaShorts(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          indexBottomNavigator = index;
          setState(() {});
        },
        backgroundColor: corPadrao,
        currentIndex: indexBottomNavigator,
        unselectedItemColor: Colors.white,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline),
            label: "Shorts",
          ),
        ],
      ),
    );
  }
}
