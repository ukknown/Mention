import 'package:app/api/profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileApi {
  static const String baseUrl = 'http://k8c105.p.ssafy.io:8000';
  static final token =
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsImVtYWlsIjoidGVzdEBnbWFpbC5jb20iLCJuaWNrbmFtZSI6IuyXrOuPhO2YhCIsImlhdCI6MTY4NDEzNDAxNiwiZXhwIjoxNjg2NzI2MDE2fQ.WE9_nCQUnPZ9hY12Isi6KjL8LzEgkkvn4ilKN_KBgetITHEftY4lIOHsV4NPPhhPrK52U9ldXdH4_N73QZaBfg";
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
