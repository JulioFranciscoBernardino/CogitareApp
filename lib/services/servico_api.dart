import 'dart:convert';
import 'package:http/http.dart' as http;

class ServicoApi {
  static const String baseUrl = 'http://localhost:3000';
  static String? _token;

  // Armazenar token após login
  static void setToken(String token) {
    _token = token;
  }

  // Remover token após logout
  static void clearToken() {
    _token = null;
  }

  // Headers padrão com autenticação
  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      };

  static Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseData;
      } else {
        throw Exception(responseData['message'] ??
            'Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      if (e is FormatException) {
        throw Exception('Erro ao processar resposta do servidor');
      }
      throw Exception('Erro de conexão: $e');
    }
  }

  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return responseData;
      } else {
        throw Exception(responseData['message'] ??
            'Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      if (e is FormatException) {
        throw Exception('Erro ao processar resposta do servidor');
      }
      throw Exception('Erro de conexão: $e');
    }
  }

  static Future<Map<String, dynamic>> put(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return responseData;
      } else {
        throw Exception(responseData['message'] ??
            'Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      if (e is FormatException) {
        throw Exception('Erro ao processar resposta do servidor');
      }
      throw Exception('Erro de conexão: $e');
    }
  }

  // Método específico para login
  static Future<Map<String, dynamic>> login(
      String email, String senha, String tipo) async {
    final response = await post('/api/auth/login', {
      'email': email,
      'senha': senha,
      'tipo': tipo,
    });

    if (response['success'] && response['data']['token'] != null) {
      setToken(response['data']['token']);
    }

    return response;
  }

  // Método para verificar se está logado
  static Future<bool> verifyToken() async {
    if (_token == null) return false;

    try {
      final response = await get('/api/auth/verify');
      return response['success'] ?? false;
    } catch (e) {
      clearToken();
      return false;
    }
  }
}
