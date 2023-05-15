import 'package:app/api/profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileApi {
  // static const String baseUrl = 'http://localhost:8000';
  static const String baseUrl = 'http://k8c105.p.ssafy.io:8000';
  static final token =
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzaGpvQGdtYWlsLmNvbSIsImVtYWlsIjoic2hqb0BnbWFpbC5jb20iLCJuaWNrbmFtZSI6IuyhsOyKue2YhCIsImlhdCI6MTY4NDEzNzY3MCwiZXhwIjoxNjg2NzI5NjcwfQ.7IR22FAP1ppukiqrz2vyP1vhb5PDMpkxoOWGja2wy_q8hi8t_8FIGYy-cg3qDxN0xoda8_XRPGP7u6srBYvZwg";
  static Future<Profile> getProfile() async {
    final url = Uri.parse('$baseUrl/member-service/me');
    try {
      final response = await http.get(url, headers: <String, String>{
        'Authorization': "Bearer $token",
      });

      if (response.statusCode == 200) {
        final List<int> bytes = response.bodyBytes;
        final String responseBody = utf8.decode(bytes);
        final Map<String, dynamic> profileJson = jsonDecode(responseBody);
        print(profileJson);
        return Profile.fromJson(profileJson);
      } else {
        print('Server responded with status code: ${response.statusCode}');
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load profile');
    }
  }

  static Future<List<Group>> getGroups() async {
    final url = Uri.parse('$baseUrl/team-service/teams');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> groupsJson = jsonDecode(response.body)['group'];
      return groupsJson.map((group) => Group.fromJson(group)).toList();
    } else {
      throw Exception('Failed to load groups');
    }
  }

  static Future<List<Mention>> getMentions() async {
    final url = Uri.parse('$baseUrl/mentions');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> mentionsJson = jsonDecode(response.body)['mentions'];
      return mentionsJson.map((mention) => Mention.fromJson(mention)).toList();
    } else {
      throw Exception('Failed to load mentions');
    }
  }
}
