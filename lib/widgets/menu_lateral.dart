import 'package:app_biblioteca/cores/cores_globais.dart';
import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  final List<Widget> children;

  const MenuLateral({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: corPadrao,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
