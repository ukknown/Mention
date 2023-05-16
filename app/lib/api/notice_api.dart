import 'package:app/api/notice_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoticeApi {
  static const String baseUrl = 'http://k8c105.p.ssafy.io:8000';
  static final token =
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0MkBnbWFpbC5jb20iLCJlbWFpbCI6InRlc3QyQGdtYWlsLmNvbSIsIm5pY2tuYW1lIjoi7KGw7Iq57ZiEIiwiaWF0IjoxNjg0MTMzMDM1LCJleHAiOjE2ODY3MjUwMzV9.ccobgT3kXLi5L0GtxrO4DPHRbpSjMWohVWePzwvUSwCB06IC-NGdGhtNdkUX5nGw8bCWzLVFzbucWCgod5ZBhw";

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
