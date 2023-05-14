import 'package:http/http.dart' as http;

Future<dynamic> fetchData() async {
  final url = Uri.parse('http://k8c105.p.ssafy.io:8000/team-service/teams/1');
  final token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJoZWxsb0BnbWFpbC5jb20iLCJlbWFpbCI6ImhlbGxvQGdtYWlsLmNvbSIsIm5pY2tuYW1lIjoi6rmA7LC97JiBIiwiaWF0IjoxNjg0MDY5NDQyLCJleHAiOjE2ODY2NjE0NDJ9.BZv6dnLYKLA1qkcPSnrGYsXjb3kdUIMSyPUSp0SYzWmt2GESc51SinHqeyaVMRGO0usPiPBX8ZJRfTCRhjCdkA';

  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    // 요청이 성공한 경우
    final jsonData = response.body;
    // 데이터 처리
    print(jsonData);
  } else {
    // 요청이 실패한 경우
    print('Error: ${response.statusCode}');
  }
}
