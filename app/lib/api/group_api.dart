import 'package:app/api/group_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode, utf8;

class GroupApi {
  final String baseUrl = 'http://k8c105.p.ssafy.io:8000';
  final String token =
      // 노준호
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJuamgzMzIxQG5hdmVyLmNvbSIsImVtYWlsIjoibmpoMzMyMUBuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuFuOykgO2YuCIsImlhdCI6MTY4NDQxOTk3MywiZXhwIjoxNjg3MDExOTczfQ.56J4Bu9u3lB0UWb236RVH7TKWsAaiSOoB887o-hYjDFbtIjcZmavaeg4LLWA_W7H4hScavCDghgMQdCyWS-JNw';
  // 여도현
  // 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ5ZGgxNTA5QGhhbm1haWwubmV0IiwiZW1haWwiOiJ5ZGgxNTA5QGhhbm1haWwubmV0Iiwibmlja25hbWUiOiLsl6zrj4TtmIQiLCJpYXQiOjE2ODQyODgzMjEsImV4cCI6MTY4Njg4MDMyMX0.hmjBNHeVhE9XkscASnC1shJxotK8wNWoumt4uUNXdgHRwPxTtWL6MzGZVGN9bXyaFIK5StjsZdqI8Iq_WtJJ5Q';

  Future<GroupDetailModel> fetchGroupData(int teamId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/team-service/teams/$teamId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<int> bytes = response.bodyBytes;
      final String responseBody = utf8.decode(bytes);
      final Map<String, dynamic> groupData = jsonDecode(responseBody);
      return GroupDetailModel.fromJson(groupData);
    } else {
      throw Exception('Failed to load group data');
    }
  }
}
