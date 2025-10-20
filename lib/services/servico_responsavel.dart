import '../models/responsavel.dart';
import '../models/endereco.dart';
import 'servico_api_responsavel.dart';

class ServicoResponsavel {
  // Métodos usando API
  static Future<Map<String, dynamic>> createEndereco(Endereco address) async {
    return await ServicoApiResponsavel.createEndereco(address);
  }

  static Future<Map<String, dynamic>> createResponsavel(
      Responsavel guardian) async {
    return await ServicoApiResponsavel.createResponsavel(guardian);
  }

  static Future<Map<String, dynamic>> createComplete({
    required Endereco address,
    required Responsavel guardian,
  }) async {
    return await ServicoApiResponsavel.createComplete(
      address: address,
      guardian: guardian,
    );
  }

  static Future<List<Responsavel>> listResponsavels() async {
    return await ServicoApiResponsavel.listResponsavels();
  }
}
