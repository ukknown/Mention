import 'package:app/api/notice_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoticeApi {
  static const String baseUrl = 'http://k8c105.p.ssafy.io:8000';

  static Future<NoticeList> getNoticeList() async {
    final url = Uri.parse('$baseUrl/notice-service/notice');
    try {
      final response = await http.get(url, headers: <String, String>{
        'Authorization':
            "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzd2FuQGdtYWlsLmNvbSIsImVtYWlsIjoic3dhbkBnbWFpbC5jb20iLCJuaWNrbmFtZSI6IuyImOyZhOuPmSIsImlhdCI6MTY4Mzk4MjQ0MywiZXhwIjoxNjgzOTgzNDQzfQ.x058IUp_tPlvj2AY1EwT-3wLS-s6trBkrd4kMfaadeiPnmqqH5b08Wn_ddjINRAAPhT2DpUy5pCDXXtA7713AQ",
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> noticeJson = jsonDecode(response.body);
        return NoticeList.fromJson(noticeJson);
      } else {
        print('Server responded with status code: ${response.statusCode}');
        throw Exception('Failed to load notices');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load notices');
    }
  }
}
