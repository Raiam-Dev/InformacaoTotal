import 'package:app_biblioteca/firebase_options.dart';
import 'package:app_biblioteca/paginas/pagina_documento_criar.dart';
import 'package:app_biblioteca/paginas/pagina_documento_exibir.dart';
import 'package:app_biblioteca/paginas/pagina_painel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'PaginaCriarDocumento': (context) => PaginaCriarDocumento(),
        'PaginaPainel': (context) => PaginaPainel(),
        'PaginaDocumento': (context) => PaginaDocumento(texto: '', title: ''),
      },
      home: PaginaPainel(),
    );
  }
}
