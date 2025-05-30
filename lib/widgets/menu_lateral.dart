import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  final double width;
  final List<Widget> children;

  const MenuLateral({super.key, required this.children, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 16),
          _menuItem(Icons.home, 'Início', () {}),
          _menuItem(Icons.video_library, 'Biblioteca', () {}),
          _menuItem(Icons.history, 'Histórico', () {}),
          const Divider(thickness: 1),
          _menuItem(Icons.settings, 'Configurações', () {}),
          _menuItem(Icons.info_outline, 'Sobre', () {}),
          const Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.black87),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
