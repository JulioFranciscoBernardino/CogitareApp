import '../models/guardian.dart';
import '../models/address.dart';
import 'database_service.dart';

class GuardianDatabaseService {
  static Future<Map<String, dynamic>> createAddress(Address address) async {
    try {
      const query = '''
        INSERT INTO endereco (Cidade, Bairro, Rua, Numero, Complemento, Cep)
        VALUES (?, ?, ?, ?, ?, ?)
      ''';

      final values = [
        address.city,
        address.neighborhood,
        address.street,
        address.number,
        address.complement,
        address.zipCode,
      ];

      final result = await DatabaseService.executeInsert(query, values);

      return {
        'success': true,
        'data': {'IdEndereco': result.insertId},
        'message': 'Endereço cadastrado com sucesso'
      };
    } catch (e) {
      return {'success': false, 'message': 'Erro ao cadastrar endereço: $e'};
    }
  }

  static Future<Map<String, dynamic>> createGuardian(Guardian guardian) async {
    try {
      const query = '''
        INSERT INTO responsavel (IdEndereco, Cpf, Nome, Email, Telefone, DataNascimento, FotoUrl)
        VALUES (?, ?, ?, ?, ?, ?, ?)
      ''';

      final values = [
        guardian.addressId,
        guardian.cpf,
        guardian.name,
        guardian.email,
        guardian.phone,
        guardian.birthDate?.toIso8601String().split('T')[0],
        guardian.photoUrl,
      ];

      final result = await DatabaseService.executeInsert(query, values);

      return {
        'success': true,
        'data': {'IdResponsavel': result.insertId},
        'message': 'Responsável cadastrado com sucesso'
      };
    } catch (e) {
      return {'success': false, 'message': 'Erro ao cadastrar responsável: $e'};
    }
  }

  static Future<Map<String, dynamic>> createComplete({
    required Address address,
    required Guardian guardian,
  }) async {
    try {
      // Primeiro cadastra o endereço
      final addressResponse = await createAddress(address);

      if (addressResponse['success'] == true) {
        final addressId = addressResponse['data']['IdEndereco'];

        // Depois cadastra o responsável com o ID do endereço
        final guardianWithAddress = guardian.copyWith(addressId: addressId);
        final guardianResponse = await createGuardian(guardianWithAddress);

        return guardianResponse;
      } else {
        return addressResponse;
      }
    } catch (e) {
      return {'success': false, 'message': 'Erro no cadastro completo: $e'};
    }
  }

  static Future<List<Guardian>> listGuardians() async {
    try {
      const query = '''
        SELECT r.*, e.Cidade, e.Bairro, e.Rua, e.Numero, e.Complemento, e.Cep
        FROM responsavel r
        LEFT JOIN endereco e ON r.IdEndereco = e.IdEndereco
      ''';

      final results = await DatabaseService.executeQuery(query);

      return results.map((row) {
        return Guardian.fromJson({
          'IdResponsavel': row['IdResponsavel'],
          'IdEndereco': row['IdEndereco'],
          'Cpf': row['Cpf'],
          'Nome': row['Nome'],
          'Email': row['Email'],
          'Telefone': row['Telefone'],
          'DataNascimento': row['DataNascimento']?.toString(),
          'FotoUrl': row['FotoUrl'],
        });
      }).toList();
    } catch (e) {
      print('Erro ao listar responsáveis: $e');
      return [];
    }
  }
}
