import 'package:flutter/material.dart';

class CardApresentacao extends StatefulWidget {
  final String title;
  final String descricao;
  final bool carregar;
  final String imagem;
  const CardApresentacao({
    required this.carregar,
    required this.descricao,
    required this.title,
    super.key,
    required this.imagem,
  });

  @override
  State<CardApresentacao> createState() => _CardApresentacaoState();
}

class _CardApresentacaoState extends State<CardApresentacao> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: EdgeInsetsGeometry.all(1),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 8, left: 8, right: 8),
            height: 250,
            child: widget.carregar
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : Image.network(widget.imagem),
          ),
          Row(
            children: [
              Icon(Icons.contactless_outlined, size: 30, color: Colors.white),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 20,
                      wordSpacing: 0.1,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.descricao,
                    style: TextStyle(
                      fontSize: 15,
                      wordSpacing: 0.1,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
