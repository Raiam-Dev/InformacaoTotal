import 'package:app_biblioteca/cores/cores_globais.dart';
import 'package:flutter/material.dart';

class MenuLateral extends StatefulWidget {
  final double width;
  final List<Widget> children;
  const MenuLateral({required this.children, required this.width, super.key});

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: corPadrao,
      width: widget.width,
      child: ListView(children: widget.children),
    );
  }
}
