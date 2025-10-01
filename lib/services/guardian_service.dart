import '../models/guardian.dart';
import '../models/address.dart';
import 'responsavel_api_service.dart';

class GuardianService {
  // Métodos usando API
  static Future<Map<String, dynamic>> createAddress(Address address) async {
    return await ResponsavelApiService.createAddress(address);
  }

  static Future<Map<String, dynamic>> createGuardian(Guardian guardian) async {
    return await ResponsavelApiService.createGuardian(guardian);
  }

  static Future<Map<String, dynamic>> createComplete({
    required Address address,
    required Guardian guardian,
  }) async {
    return await ResponsavelApiService.createComplete(
      address: address,
      guardian: guardian,
    );
  }

  static Future<List<Guardian>> listGuardians() async {
    return await ResponsavelApiService.listGuardians();
  }
}
