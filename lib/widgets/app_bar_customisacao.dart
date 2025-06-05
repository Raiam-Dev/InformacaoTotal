import 'package:app_biblioteca/cores/cores_globais.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppBarCustomisacao extends AppBar {
  AppBarCustomisacao({super.key});

  @override
  State<AppBarCustomisacao> createState() => _AppbarCustomisacaoState();
}

class _AppbarCustomisacaoState extends State<AppBarCustomisacao> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,
      toolbarHeight: 50,
      title: SizedBox(
        width: 800,
        height: 40,
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onFieldSubmitted: (value) {},
        ),
      ),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(child: Text('Programacao')),
              PopupMenuItem(child: Text('Eletronica')),
              PopupMenuItem(child: Text('Empreendedorismo')),
            ];
          },
        ),
      ],
      elevation: 0,
      backgroundColor: corPadrao,
      surfaceTintColor: corPadrao,
    );
  }
}
