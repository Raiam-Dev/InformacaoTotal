import 'package:app_biblioteca/servico/clound_firebase_servico.dart';
import 'package:app_biblioteca/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';

class PaginaCriarDocumento extends StatefulWidget {
  const PaginaCriarDocumento({super.key});

  @override
  State<PaginaCriarDocumento> createState() => _PaginaCriarDocumentoState();
}

class _PaginaCriarDocumentoState extends State<PaginaCriarDocumento> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerImagem = TextEditingController();
  final TextEditingController _controllerTexto = TextEditingController();
  final TextEditingController _controllerSubtitulo = TextEditingController();
  final CloundFirebaseServico dataBase = CloundFirebaseServico();

  bool _salvando = false;

  Future<void> salvarDocumento() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _salvando = true);

    final documento = Documento(
      _controllerImagem.text.trim(),
      _controllerTitle.text.trim(),
      _controllerSubtitulo.text.trim(),
      _controllerTexto.text.trim(),
    );

    final mapa = {
      'title': documento.title,
      'subtitulo': documento.subtitulo,
      'imagem': documento.imagem,
      'texto': documento.texto,
    };

    try {
      await dataBase.criarDocumento(mapa);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Documento salvo com sucesso!')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao salvar documento: $e')));
    } finally {
      if (mounted) setState(() => _salvando = false);
    }
  }

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerImagem.dispose();
    _controllerTexto.dispose();
    _controllerSubtitulo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;

    final menuLateral = MenuLateral(width: largura * 0.20, children: const []);

    final formulario = Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextFormField(
            controller: _controllerTitle,
            decoration: const InputDecoration(
              labelText: 'Título',
              border: OutlineInputBorder(),
              hintText: 'Digite o título do documento',
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Título obrigatório' : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _controllerSubtitulo,
            decoration: const InputDecoration(
              labelText: 'Subtítulo',
              border: OutlineInputBorder(),
              hintText: 'Digite o subtítulo do documento',
            ),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'Subtítulo obrigatório'
                : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _controllerImagem,
            decoration: const InputDecoration(
              labelText: 'URL da Imagem de Capa',
              border: OutlineInputBorder(),
              hintText: 'Cole a URL da imagem de capa',
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return 'URL da imagem é obrigatória';
              }
              final urlPattern =
                  r'(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|jpeg|png|gif|bmp)';
              final regex = RegExp(urlPattern, caseSensitive: false);
              if (!regex.hasMatch(v.trim())) {
                return 'Informe uma URL válida de imagem';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _controllerTexto,
            decoration: const InputDecoration(
              labelText: 'Conteúdo do Documento',
              border: OutlineInputBorder(),
              hintText: 'Digite o texto completo do documento',
              alignLabelWithHint: true,
            ),
            maxLines: 10,
            minLines: 6,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Texto obrigatório' : null,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _salvando ? null : salvarDocumento,
              icon: _salvando
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.save),
              label: Text(_salvando ? 'Salvando...' : 'Salvar Documento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Documento'),
        backgroundColor: Colors.redAccent,
      ),
      drawer: largura < 800 ? Drawer(child: menuLateral) : null,
      body: largura >= 800
          ? Row(
              children: [
                menuLateral,
                Expanded(child: formulario),
              ],
            )
          : formulario,
    );
  }
}

class Documento {
  final String title;
  final String subtitulo;
  final String imagem;
  final String texto;

  Documento(this.imagem, this.title, this.subtitulo, this.texto);
}
