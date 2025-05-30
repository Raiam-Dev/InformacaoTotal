import 'package:flutter/material.dart';
import 'package:app_biblioteca/cores/cores_globais.dart';
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
    if (largura > 1200) return 5;
    if (largura > 1000) return 4;
    if (largura > 800) return 3;
    if (largura > 600) return 2;
    return 1;
  }

  Widget _buildCard(Map<String, dynamic> doc, double cardHeight) {
    final imagemUrl = doc['imagem'] ?? 'https://via.placeholder.com/150';
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PaginaDocumento(texto: doc['texto'] ?? ''),
          ),
        );
      },
      child: SizedBox(
        height: cardHeight,
        child: Card(
          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: cardHeight * 0.6,
                width: double.infinity,
                child: Image.network(
                  imagemUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc['title'] ?? 'Sem título',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            doc['texto'] ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.play_circle_fill,
                      color: Colors.deepOrangeAccent,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final colunas = _calcularColunas(largura);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBarCustomisacao(),
      drawer: largura < 800
          ? Drawer(
              child: MenuLateral(
                width: largura * 0.20,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, 'PaginaCriarDocumento'),
                    child: const Text('Criar Documento'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: Row(
        children: [
          if (largura >= 800) MenuLateral(width: largura * 0.18, children: []),
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: colunas,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: documentos.length,
                        itemBuilder: (context, index) {
                          final doc = documentos[index];
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              final cardHeight = constraints.maxWidth * 0.75;
                              return _buildCard(doc, cardHeight);
                            },
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.pushNamed(context, 'PaginaCriarDocumento');
          _carregarDocumentos();
        },
        icon: const Icon(Icons.add),
        label: const Text('Criar Documento'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }
}
