import '../models/elder.dart';
import 'elder_database_service.dart';

class ElderService {
  static Future<Map<String, dynamic>> createElder(Elder elder) async {
    return await ElderDatabaseService.createElder(elder);
  }

  static Future<List<Elder>> listElders() async {
    return await ElderDatabaseService.listElders();
  }

  static Future<List<Elder>> listEldersByGuardian(int guardianId) async {
    return await ElderDatabaseService.listEldersByGuardian(guardianId);
  }
}
