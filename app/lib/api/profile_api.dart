import 'package:app/api/profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileApi {
  // static const String baseUrl = 'http://localhost:8000';
  static const String baseUrl = 'http://k8c105.p.ssafy.io:8000';
  static final token =
      // 노준호
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJuamgzMzIxQG5hdmVyLmNvbSIsImVtYWlsIjoibmpoMzMyMUBuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuFuOykgO2YuCIsImlhdCI6MTY4NDQxOTk3MywiZXhwIjoxNjg3MDExOTczfQ.56J4Bu9u3lB0UWb236RVH7TKWsAaiSOoB887o-hYjDFbtIjcZmavaeg4LLWA_W7H4hScavCDghgMQdCyWS-JNw';
  // 여도현
  // 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ5ZGgxNTA5QGhhbm1haWwubmV0IiwiZW1haWwiOiJ5ZGgxNTA5QGhhbm1haWwubmV0Iiwibmlja25hbWUiOiLsl6zrj4TtmIQiLCJpYXQiOjE2ODQyODgzMjEsImV4cCI6MTY4Njg4MDMyMX0.hmjBNHeVhE9XkscASnC1shJxotK8wNWoumt4uUNXdgHRwPxTtWL6MzGZVGN9bXyaFIK5StjsZdqI8Iq_WtJJ5Q';
  static Future<Profile> getProfile() async {
    final url = Uri.parse('$baseUrl/member-service/me');
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
  }

  static Future<List<Group>> getGroups() async {
    final url = Uri.parse('$baseUrl/team-service/teams');
    final response = await http.get(url, headers: <String, String>{
      'Authorization': "Bearer $token",
    });
    if (response.statusCode == 200) {
      final List<int> bytes = response.bodyBytes;
      final String responseBody = utf8.decode(bytes);
      final List<dynamic> groupsJson = jsonDecode(responseBody);
      print(groupsJson);
      return groupsJson.map((group) => Group.fromJson(group)).toList();
    } else {
      throw Exception('Failed to load groups');
    }
  }

  static Future<List<Mention>> getMentions() async {
    final url = Uri.parse('$baseUrl/mention-service/mentions');
    final response = await http.get(url, headers: <String, String>{
      'Authorization': "Bearer $token",
    });
    if (response.statusCode == 200) {
      final List<int> bytes = response.bodyBytes;
      final String responseBody = utf8.decode(bytes);
      final List<dynamic> mentionsJson = jsonDecode(responseBody);
      print(mentionsJson);
      return mentionsJson.map((mention) => Mention.fromJson(mention)).toList();
    } else {
      throw Exception('Failed to load mentions');
    }
  }
}
