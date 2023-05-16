import 'package:http/http.dart' as http;
import 'dart:convert';
import 'group_model.dart';
import 'dart:convert' show jsonDecode, utf8;

final String baseUrl = 'http://k8c105.p.ssafy.io:8000';
final String token =
    'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJiYWJvQGdtYWlsLmNvbSIsImVtYWlsIjoiYmFib0BnbWFpbC5jb20iLCJuaWNrbmFtZSI6IuuwlOuztCIsImlhdCI6MTY4NDEzMjg2NiwiZXhwIjoxNjg2NzI0ODY2fQ.WW7MH3_ksWdUuOh0hlkb4CuNtat_khLIiXPBsF3jcTPwuNsQ0NTtTfLsFEW1kDp7bcOCCykdmpkDod-lM4nbYA';

Future<GroupDetailModel> fetchGroupData() async {
  final response = await http.get(
    Uri.parse(
        '$baseUrl/team-service/teams/1'), // Replace 'YOUR_ENDPOINT' with the correct endpoint.
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    String body = utf8.decode(response.bodyBytes);
    return GroupDetailModel.fromJson(jsonDecode(body));
  } else {
    throw Exception('Failed to load group data');
  }
}
