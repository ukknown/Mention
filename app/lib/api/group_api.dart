import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  const String baseurl = 'http://k8c105.p.ssafy.io:8000';
  const String groupDetailurl = '$baseurl/team-service/teams/1';
  // http://k8c105.p.ssafy.io:8000/team-service/teams/1

  try {
    final response = await http.get(Uri.parse(groupDetailurl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // 데이터 처리 로직 작성
      print(jsonData);
    } else {
      print('API 호출 실패: ${response.statusCode}');
    }
  } catch (e) {
    print('API 호출 중 오류 발생: $e');
  }
}
