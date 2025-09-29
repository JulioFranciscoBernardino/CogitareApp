import '../models/caregiver.dart';
import '../models/address.dart';
import 'caregiver_database_service.dart';

class CaregiverService {
  // Métodos usando banco de dados direto
  static Future<Map<String, dynamic>> createAddress(Address address) async {
    return await CaregiverDatabaseService.createAddress(address);
  }

  static Future<Map<String, dynamic>> createCaregiver(
      Caregiver caregiver) async {
    return await CaregiverDatabaseService.createCaregiver(caregiver);
  }

  static Future<Map<String, dynamic>> createComplete({
    required Address address,
    required Caregiver caregiver,
  }) async {
    return await CaregiverDatabaseService.createComplete(
      address: address,
      caregiver: caregiver,
    );
  }

  static Future<List<Caregiver>> listCaregivers() async {
    return await CaregiverDatabaseService.listCaregivers();
  }
}
