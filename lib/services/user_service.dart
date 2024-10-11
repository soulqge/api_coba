import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  // Fetch users from the API
  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Register new user
  Future<void> registerUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode != 201) { // Assuming 201 is returned on successful creation
      throw Exception('Failed to register user: ${response.body}');
    }
  }

  // Update user method
  Future<bool> updateUser(String userId, String newUserName, String newPassword) async {
    final url = Uri.parse('$baseUrl/$userId'); 

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': newUserName,
        'password': newPassword,
        // Add other required fields here
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true; // Update was successful
    } else {
      throw Exception('Failed to update user: ${response.body}');
    }
  }

  //delete
  Future<bool> deleteUser(String userId) async {
    final url = Uri.parse('$baseUrl/$userId');

    final response = await http.delete(url);

    return response.statusCode == 204; // Check for successful deletion (204 No Content)
  }
}
