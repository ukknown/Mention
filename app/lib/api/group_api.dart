import 'package:app/api/profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroupApi {
  static const String baseUrl = 'http://k8c105.p.ssafy.io:8000';
  static final token =
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJoZWxsb0BnbWFpbC5jb20iLCJlbWFpbCI6ImhlbGxvQGdtYWlsLmNvbSIsIm5pY2tuYW1lIjoi6rmA7LC97JiBIiwiaWF0IjoxNjg0MDY5NDQyLCJleHAiOjE2ODY2NjE0NDJ9.BZv6dnLYKLA1qkcPSnrGYsXjb3kdUIMSyPUSp0SYzWmt2GESc51SinHqeyaVMRGO0usPiPBX8ZJRfTCRhjCdkA";
  static Future<Group> getGroup() async {
    final url = Uri.parse('$baseUrl/team-service/teams/1');
    try {
      final response = await http.get(url, headers: <String, String>{
        'Authorization': "Bearer $token",
      });

      if (response.statusCode == 200) {
        final List<int> bytes = response.bodyBytes;
        final String responseBody = utf8.decode(bytes);
        final Map<String, dynamic> groupJson = jsonDecode(responseBody);
        print(groupJson);
        return Group.fromJson(groupJson);
      } else {
        print('Server responded with status code: ${response.statusCode}');
        throw Exception('Failed to load group');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load group');
    }
  }

  static Future<List<Group>> getGroups() async {
    final url = Uri.parse('$baseUrl/groups');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> groupsJson = jsonDecode(response.body)['group'];
      return groupsJson.map((group) => Group.fromJson(group)).toList();
    } else {
      throw Exception('Failed to load groups');
    }
  }
}
