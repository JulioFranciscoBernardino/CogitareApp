import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/cuidador_proximo.dart';
import '../models/responsavel.dart';
import '../models/cuidador.dart';
import '../models/endereco.dart';

class ServicoCuidadoresProximos {
  static const String baseUrl = 'http://localhost:3000/api';

  // Busca cuidadores próximos baseado no endereço do responsável
  static Future<List<CuidadorProximo>> getCuidadorProximos(
    Responsavel guardian, {
    double maxDistanceKm = 999999.0, // Distância muito alta para não limitar
    int limit = 10,
  }) async {
    try {
      // Usa coordenadas de São Paulo como padrão
      final response = await http.get(
        Uri.parse(
            '$baseUrl/nearby-caregivers/nearby/coordinates?latitude=-23.5505&longitude=-46.6333&max_distance=$maxDistanceKm&limit=$limit'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final List<dynamic> caregiversData = data['data'];
          print('✅ Dados reais do banco carregados com sucesso!');
          return caregiversData
              .map((json) => CuidadorProximo.fromJson(json))
              .toList();
        }
      }

      // Se não conseguiu buscar do backend, retorna dados mock
      print('⚠️ Backend não disponível - usando dados mock');
      print(
          '💡 Para usar dados reais: inicie o backend com "node server.js" na pasta backend');
      return _getMockCuidadors(limit);
    } catch (e) {
      print('❌ Erro ao buscar cuidadores próximos: $e');
      print('🔄 Usando dados mock como fallback');
      // Retorna dados mock em caso de erro
      return _getMockCuidadors(limit);
    }
  }

  // Busca cuidadores próximos usando coordenadas específicas
  static Future<List<CuidadorProximo>> getCuidadorProximosByCoordinates(
    double latitude,
    double longitude, {
    double maxDistanceKm = 999999.0, // Distância muito alta para não limitar
    int limit = 10,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/nearby-caregivers/nearby/coordinates?latitude=$latitude&longitude=$longitude&max_distance=$maxDistanceKm&limit=$limit'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final List<dynamic> caregiversData = data['data'];
          return caregiversData
              .map((json) => CuidadorProximo.fromJson(json))
              .toList();
        }
      }

      // Se não conseguiu buscar do backend, retorna dados mock
      return _getMockCuidadors(limit);
    } catch (e) {
      print('Erro ao buscar cuidadores próximos por coordenadas: $e');
      // Retorna dados mock em caso de erro
      return _getMockCuidadors(limit);
    }
  }

  // Método para buscar cuidadores próximos com filtros
  static Future<List<CuidadorProximo>> searchCuidadorProximos({
    required Responsavel guardian,
    double? maxDistanceKm,
    double? minHourlyRate,
    double? maxHourlyRate,
    bool? onlyAvailable,
    int limit = 10,
  }) async {
    try {
      final queryParams = <String, String>{
        'guardian_id': guardian.id.toString(),
        'max_distance': (maxDistanceKm ?? 999999.0).toString(),
        'limit': limit.toString(),
      };

      if (minHourlyRate != null) {
        queryParams['min_hourly_rate'] = minHourlyRate.toString();
      }
      if (maxHourlyRate != null) {
        queryParams['max_hourly_rate'] = maxHourlyRate.toString();
      }
      if (onlyAvailable == true) {
        queryParams['only_available'] = 'true';
      }

      final uri = Uri.parse('$baseUrl/nearby-caregivers/nearby').replace(
        queryParameters: queryParams,
      );

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final List<dynamic> caregiversData = data['data'];
          return caregiversData
              .map((json) => CuidadorProximo.fromJson(json))
              .toList();
        }
      }

      // Se não conseguiu buscar do backend, retorna dados mock
      return _getMockCuidadors(limit);
    } catch (e) {
      print('Erro ao buscar cuidadores próximos com filtros: $e');
      // Retorna dados mock em caso de erro
      return _getMockCuidadors(limit);
    }
  }

  // Método para buscar cuidadores próximos por coordenadas com filtros
  static Future<List<CuidadorProximo>> searchCuidadorProximosByCoordinates({
    required double latitude,
    required double longitude,
    double? maxDistanceKm,
    double? minHourlyRate,
    double? maxHourlyRate,
    bool? onlyAvailable,
    int limit = 10,
  }) async {
    try {
      final queryParams = <String, String>{
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'max_distance': (maxDistanceKm ?? 999999.0).toString(),
        'limit': limit.toString(),
      };

      if (minHourlyRate != null) {
        queryParams['min_hourly_rate'] = minHourlyRate.toString();
      }
      if (maxHourlyRate != null) {
        queryParams['max_hourly_rate'] = maxHourlyRate.toString();
      }
      if (onlyAvailable == true) {
        queryParams['only_available'] = 'true';
      }

      final uri =
          Uri.parse('$baseUrl/nearby-caregivers/nearby/coordinates').replace(
        queryParameters: queryParams,
      );

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final List<dynamic> caregiversData = data['data'];
          return caregiversData
              .map((json) => CuidadorProximo.fromJson(json))
              .toList();
        }
      }

      // Se não conseguiu buscar do backend, retorna dados mock
      return _getMockCuidadors(limit);
    } catch (e) {
      print(
          'Erro ao buscar cuidadores próximos por coordenadas com filtros: $e');
      // Retorna dados mock em caso de erro
      return _getMockCuidadors(limit);
    }
  }

  // Método para gerar dados mock de cuidadores
  static List<CuidadorProximo> _getMockCuidadors(int limit) {
    final random = Random();
    final mockCuidadors = <CuidadorProximo>[];

    final names = [
      'Maria Silva',
      'João Santos',
      'Ana Costa',
      'Pedro Oliveira',
      'Carla Mendes',
      'Roberto Lima',
      'Fernanda Alves',
      'Carlos Pereira',
      'Lucia Rodrigues',
      'Antonio Ferreira',
    ];

    final cities = [
      'São Paulo',
      'Rio de Janeiro',
      'Belo Horizonte',
      'Salvador',
      'Brasília',
      'Fortaleza',
      'Manaus',
      'Curitiba',
      'Recife',
      'Porto Alegre',
    ];

    for (int i = 0; i < limit && i < names.length; i++) {
      final name = names[i];
      final city = cities[random.nextInt(cities.length)];
      final distance = 5.0 + random.nextDouble() * 50.0; // Entre 5 e 55 km
      final hourlyRate =
          15.0 + random.nextDouble() * 35.0; // Entre R$ 15 e R$ 50
      final isAvailable = random.nextBool();

      final caregiver = Cuidador(
        id: i + 1,
        name: name,
        email: '${name.toLowerCase().replaceAll(' ', '.')}@email.com',
        phone: '(11) 99999-${1000 + i}',
        cpf: '123.456.789-0${i}',
        birthDate: DateTime(1980 + random.nextInt(20), random.nextInt(12) + 1,
            random.nextInt(28) + 1),
        photoUrl: null,
        biography:
            'Cuidador experiente com ${5 + random.nextInt(15)} anos de experiência.',
        smokes: random.nextBool() ? 'Não' : 'Sim',
        hasChildren: random.nextBool() ? 'Sim' : 'Não',
        hasDrivingLicense: random.nextBool() ? 'Sim' : 'Não',
        hasCar: random.nextBool() ? 'Sim' : 'Não',
      );

      final address = Endereco(
        id: i + 1,
        city: city,
        neighborhood: 'Centro',
        street: 'Rua das Flores',
        number: '${100 + i}',
        complement: 'Apto ${i + 1}',
        zipCode: '01234-${100 + i}',
      );

      mockCuidadors.add(CuidadorProximo(
        caregiver: caregiver,
        address: address,
        distance: distance,
        hourlyRate: hourlyRate,
        isAvailable: isAvailable,
      ));
    }

    return mockCuidadors;
  }
}
