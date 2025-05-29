import 'dart:convert';
import 'package:app_biblioteca/servico/modeloException/exception_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloundFirebaseServico {
  FirebaseFirestore bancoDados = FirebaseFirestore.instance;

  ///TODO:Focar Aqui
  ///Criar Documentos
  ///Editar Documentos
  ///Buscar Documentos
  ///Excluir Documentos

  Future<bool> criarDocumento(Map<String, dynamic> documento) async {
    try {
      await bancoDados.collection('documentos').add(documento);
      return true;
    } on FirebaseException catch (erro) {
      if (erro.code == 'unavailable') {
        throw ExceptionDatabase(
          mensagem: "Sem conexão com a internet ou serviço indisponível",
        );
      } else {
        throw ExceptionDatabase(mensagem: "Erro Desconhecido");
      }
    } catch (erro) {
      throw ExceptionDatabase(mensagem: "Consultar Código");
    }
  }

  Future<List<Map<String, dynamic>>> buscarDocumentos() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final snapshot = await firestore.collection('documentos').get();

      List<Map<String, dynamic>> listaUsuarios = snapshot.docs.map((doc) {
        return {'id': doc.id, ...doc.data()};
      }).toList();

      return listaUsuarios;
    } catch (e) {
      print('Erro ao buscar dados: $e');
      return [];
    }
  }
}
