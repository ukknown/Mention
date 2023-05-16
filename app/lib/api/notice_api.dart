import 'package:app/api/notice_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoticeApi {
  static const String baseUrl = 'http://k8c105.p.ssafy.io:8000';
  static final token =
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJqb25rdWtAZ21haWwuY29tIiwiZW1haWwiOiJqb25rdWtAZ21haWwuY29tIiwibmlja25hbWUiOiLstZzsooXsmrEiLCJpYXQiOjE2ODQyMzgwMTUsImV4cCI6MTY4NjgzMDAxNX0.9sk-d3ghnJk7C_aI7Bx-9ProSaDFV7aZ3F_t9DY8cl3stS6Aetz79UfmS2pyjW0DAu5NaLwRSgKdHIAxLn1Tbw";

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
