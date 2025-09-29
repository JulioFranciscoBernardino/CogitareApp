import '../models/guardian.dart';
import '../models/address.dart';
import 'guardian_database_service.dart';

class GuardianService {
  // Métodos usando banco de dados direto
  static Future<Map<String, dynamic>> createAddress(Address address) async {
    return await GuardianDatabaseService.createAddress(address);
  }

  static Future<Map<String, dynamic>> createGuardian(Guardian guardian) async {
    return await GuardianDatabaseService.createGuardian(guardian);
  }

  static Future<Map<String, dynamic>> createComplete({
    required Address address,
    required Guardian guardian,
  }) async {
    return await GuardianDatabaseService.createComplete(
      address: address,
      guardian: guardian,
    );
  }

  static Future<List<Guardian>> listGuardians() async {
    return await GuardianDatabaseService.listGuardians();
  }
}
