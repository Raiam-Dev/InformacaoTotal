import 'package:app_biblioteca/cores/cores_globais.dart';
import 'package:app_biblioteca/servico/clound_firebase_servico.dart';
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
      _controllerImagem.text.trim().isEmpty
          ? 'https://i.ytimg.com/vi/vgjovgJEpec/maxresdefault.jpg'
          : _controllerImagem.text.trim(),
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
        const SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text('Documento salvo com sucesso!'),
          backgroundColor: Colors.green,
        ),
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
    final formulario = Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorErrorColor: Colors.red,
            cursorColor: Colors.white,

            controller: _controllerTitle,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),

              labelText: 'Título',
              labelStyle: TextStyle(color: Colors.white),

              hintText: 'Digite o título do documento',
              hintStyle: TextStyle(color: Colors.white),

              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Título obrigatório' : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorErrorColor: Colors.red,
            cursorColor: Colors.white,

            controller: _controllerSubtitulo,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),

              labelText: 'Subtítulo',
              labelStyle: TextStyle(color: Colors.white),

              hintText: 'Digite o subtítulo do documento',
              hintStyle: TextStyle(color: Colors.white),

              border: OutlineInputBorder(),
            ),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'Subtítulo obrigatório'
                : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorErrorColor: Colors.red,
            cursorColor: Colors.white,

            controller: _controllerImagem,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),

              labelText: 'URL da Imagem de Capa',
              labelStyle: TextStyle(color: Colors.white),

              hintText: 'Cole a URL da imagem de capa',
              hintStyle: TextStyle(color: Colors.white),

              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorErrorColor: Colors.red,
            cursorColor: Colors.white,

            controller: _controllerTexto,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),

              labelText: 'Conteúdo do Documento',
              labelStyle: TextStyle(color: Colors.white),

              hintText: 'Digite o texto completo do documento',
              hintStyle: TextStyle(color: Colors.white),

              border: OutlineInputBorder(),
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
                  : const Icon(Icons.save, color: Colors.white),
              label: Text(
                _salvando ? 'Salvando...' : 'Salvar Documento',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: corPadrao,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Criar Documento',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: corPadrao,
      ),
      body: largura >= 800
          ? Row(children: [Expanded(child: formulario)])
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
