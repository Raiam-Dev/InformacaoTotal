import 'package:app_biblioteca/cores/cores_globais.dart';
import 'package:flutter/material.dart';

class AppBarCustomisacao extends AppBar {
  AppBarCustomisacao({super.key});

  @override
  State<AppBarCustomisacao> createState() => _AppbarCustomisacaoState();
}

class _AppbarCustomisacaoState extends State<AppBarCustomisacao> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
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
      leading: Icon(Icons.book_rounded, size: 30, color: Colors.white),
      elevation: 0,
      backgroundColor: corPadrao,
      surfaceTintColor: corPadrao,
    );
  }
}
