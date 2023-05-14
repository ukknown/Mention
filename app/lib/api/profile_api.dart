import 'package:app/api/profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileApi {
  static const String baseUrl = 'http://k8c105.p.ssafy.io:8000';
  static final token =
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJuamgzMzIxQG5hdmVyLmNvbSIsImVtYWlsIjoibmpoMzMyMUBuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuFuOykgO2YuCIsImlhdCI6MTY4NDA2Njk1NCwiZXhwIjoxNjg2NjU4OTU0fQ.HCwqWAat8tsT3GYsWLXb3YKznWP-Pdk7c-0GMvRn3wgMwNQeZbp6j2KpVBqyulVRiA7aa3fx6bqAyRPHxYhAJw";
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
    final url = Uri.parse('$baseUrl/groups');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> groupsJson = jsonDecode(response.body)['group'];
      return groupsJson.map((group) => Group.fromJson(group)).toList();
    } else {
      throw Exception('Failed to load groups');
    }
  }

  static Future<List<Mention>> getMentions() async {
    final url =
        Uri.parse('$baseUrl/mentions'); // 이 부분은 실제 API endpoint에 따라 수정해야 합니다.
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> mentionsJson = jsonDecode(response.body)['mentions'];
      return mentionsJson.map((mention) => Mention.fromJson(mention)).toList();
    } else {
      throw Exception('Failed to load mentions');
    }
  }
}
