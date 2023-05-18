import 'package:app/api/notice_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoticeApi {
  static const String baseUrl = 'http://k8c105.p.ssafy.io:8000';
  static final token =
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ5ZGgxNTA5QGhhbm1haWwubmV0IiwiZW1haWwiOiJ5ZGgxNTA5QGhhbm1haWwubmV0Iiwibmlja25hbWUiOiLsl6zrj4TtmIQiLCJpYXQiOjE2ODQyODgzMjEsImV4cCI6MTY4Njg4MDMyMX0.hmjBNHeVhE9XkscASnC1shJxotK8wNWoumt4uUNXdgHRwPxTtWL6MzGZVGN9bXyaFIK5StjsZdqI8Iq_WtJJ5Q";

  static Future<List<Notice>> getNoticeList() async {
    final url = Uri.parse('$baseUrl/notification-service/notifications');
    final response = await http.get(url, headers: <String, String>{
      'Authorization': "Bearer $token",
    });

    if (response.statusCode == 200) {
      final List<int> bytes = response.bodyBytes;
      final String responseBody = utf8.decode(bytes);
      final List<dynamic> noticesJson = jsonDecode(responseBody);
      print(noticesJson);
      return noticesJson.map((notice) => Notice.fromJson(notice)).toList();
    } else {
      print('Server responded with status code: ${response.statusCode}');
      throw Exception('Failed to load notices');
    }
  }
}
