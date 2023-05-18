import 'package:app/api/group_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode, utf8;

class GroupApi {
  final String baseUrl = 'http://k8c105.p.ssafy.io:8000';
  final String token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJuamgzMzIxQG5hdmVyLmNvbSIsImVtYWlsIjoibmpoMzMyMUBuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuFuOykgO2YuCIsImlhdCI6MTY4NDM5Mjk2NCwiZXhwIjoxNjg2OTg0OTY0fQ._cBR1s6iVJXKOU_HoDOQ8ucIY4n8WcapsyvflASAXCB5R_ZGCF5XRtNwo702UoEFeTrV1POXjwCBMLGOP035Jw';

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
