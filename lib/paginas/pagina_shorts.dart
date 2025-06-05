import 'package:app_biblioteca/cores/cores_globais.dart';
import 'package:flutter/material.dart';

class PaginaShorts extends StatefulWidget {
  const PaginaShorts({super.key});

  @override
  State<PaginaShorts> createState() => _PaginaShortsState();
}

class _PaginaShortsState extends State<PaginaShorts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: corPadrao);
  }
}
