import '../models/caregiver.dart';
import '../models/address.dart';
import 'database_service.dart';

class CaregiverDatabaseService {
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

  static Future<Map<String, dynamic>> createCaregiver(
      Caregiver caregiver) async {
    try {
      const query = '''
        INSERT INTO cuidador (IdEndereco, Cpf, Nome, Email, Telefone, Senha, DataNascimento, 
                             FotoUrl, Biografia, Fumante, TemFilhos, PossuiCNH, TemCarro)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      ''';

      final values = [
        caregiver.addressId,
        caregiver.cpf,
        caregiver.name,
        caregiver.email,
        caregiver.phone,
        caregiver.password,
        caregiver.birthDate?.toIso8601String().split('T')[0],
        caregiver.photoUrl,
        caregiver.biography,
        caregiver.smokes,
        caregiver.hasChildren,
        caregiver.hasDrivingLicense,
        caregiver.hasCar,
      ];

      final result = await DatabaseService.executeInsert(query, values);

      return {
        'success': true,
        'data': {'IdCuidador': result.insertId},
        'message': 'Cuidador cadastrado com sucesso'
      };
    } catch (e) {
      return {'success': false, 'message': 'Erro ao cadastrar cuidador: $e'};
    }
  }

  static Future<Map<String, dynamic>> createComplete({
    required Address address,
    required Caregiver caregiver,
  }) async {
    try {
      // Primeiro cadastra o endereço
      final addressResponse = await createAddress(address);

      if (addressResponse['success'] == true) {
        final addressId = addressResponse['data']['IdEndereco'];

        // Depois cadastra o cuidador com o ID do endereço
        final caregiverWithAddress = caregiver.copyWith(addressId: addressId);
        final caregiverResponse = await createCaregiver(caregiverWithAddress);

        return caregiverResponse;
      } else {
        return addressResponse;
      }
    } catch (e) {
      return {'success': false, 'message': 'Erro no cadastro completo: $e'};
    }
  }

  static Future<List<Caregiver>> listCaregivers() async {
    try {
      const query = '''
        SELECT c.*, e.Cidade, e.Bairro, e.Rua, e.Numero, e.Complemento, e.Cep
        FROM cuidador c
        LEFT JOIN endereco e ON c.IdEndereco = e.IdEndereco
      ''';

      final results = await DatabaseService.executeQuery(query);

      return results.map((row) {
        return Caregiver.fromJson({
          'IdCuidador': row['IdCuidador'],
          'IdEndereco': row['IdEndereco'],
          'Cpf': row['Cpf'],
          'Nome': row['Nome'],
          'Email': row['Email'],
          'Telefone': row['Telefone'],
          'Senha': row['Senha'],
          'DataNascimento': row['DataNascimento']?.toString(),
          'FotoUrl': row['FotoUrl'],
          'Biografia': row['Biografia'],
          'Fumante': row['Fumante'],
          'TemFilhos': row['TemFilhos'],
          'PossuiCNH': row['PossuiCNH'],
          'TemCarro': row['TemCarro'],
        });
      }).toList();
    } catch (e) {
      print('Erro ao listar cuidadores: $e');
      return [];
    }
  }
}
