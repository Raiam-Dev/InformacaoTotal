import 'package:app_biblioteca/servico/modeloException/exception_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;
CollectionReference<Map<String, dynamic>> docRef = _db.collection('documentos');

class CloundFirebaseServico {
  //TODO:Check das Exceptions do Firebase
  Future<void> atualizarDocumento(
    String docId,
    Map<String, dynamic> docMap,
  ) async {
    try {
      await docRef.doc(docId).update(docMap);
    } on FirebaseException catch (_) {
      throw ExceptionDatabase(mensagem: "Erro vindo do firebase");
    } catch (erro) {
      throw ExceptionDatabase(mensagem: 'Erro desconhecido');
    }
  }

  Future<void> excluirDocumento(String docId) async {
    try {
      await docRef.doc(docId).delete();
    } on FirebaseException catch (_) {
      throw ExceptionDatabase(mensagem: "Erro vindo do firebase");
    } catch (erro) {
      throw ExceptionDatabase(mensagem: 'Erro desconhecido');
    }
  }

  Future<bool> criarDocumento(Map<String, dynamic> documento) async {
    try {
      await docRef.add(documento);
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
      final snapshot = await docRef.get();

      List<Map<String, dynamic>> listaUsuarios = snapshot.docs.map((doc) {
        return {'id': doc.id, ...doc.data()};
      }).toList();
      return listaUsuarios;
    } catch (e) {
      return [];
    }
  }
}
