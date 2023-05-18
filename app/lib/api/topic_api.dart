import 'package:app/api/topic_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TopicApi {
  // static const String baseUrl = 'http://localhost:8000';
  static const String baseUrl = 'http://k8c105.p.ssafy.io:8000';
  static final token =
      // 노준호
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJuamgzMzIxQG5hdmVyLmNvbSIsImVtYWlsIjoibmpoMzMyMUBuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuFuOykgO2YuCIsImlhdCI6MTY4NDQxOTk3MywiZXhwIjoxNjg3MDExOTczfQ.56J4Bu9u3lB0UWb236RVH7TKWsAaiSOoB887o-hYjDFbtIjcZmavaeg4LLWA_W7H4hScavCDghgMQdCyWS-JNw';
  // 여도현
  // 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ5ZGgxNTA5QGhhbm1haWwubmV0IiwiZW1haWwiOiJ5ZGgxNTA5QGhhbm1haWwubmV0Iiwibmlja25hbWUiOiLsl6zrj4TtmIQiLCJpYXQiOjE2ODQyODgzMjEsImV4cCI6MTY4Njg4MDMyMX0.hmjBNHeVhE9XkscASnC1shJxotK8wNWoumt4uUNXdgHRwPxTtWL6MzGZVGN9bXyaFIK5StjsZdqI8Iq_WtJJ5Q';

  static Future<TopicRandom> getRandomTopic(int teamId) async {
    final url =
        Uri.parse('$baseUrl/topic-service/topics/random/${teamId.toString()}');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      final List<int> bytes = response.bodyBytes;
      final String responseBody = utf8.decode(bytes);
      final Map<String, dynamic> randomTopic = jsonDecode(responseBody);
      print(randomTopic);
      return TopicRandom.fromJson(randomTopic);
    } else {
      print('Server responded with status code: ${response.statusCode}');
      throw Error();
    }
  }

  static Future<void> createTopic(int teamId, int topicId) async {
    final url = Uri.parse('$baseUrl/mention-service/votes');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': "Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'teamId': teamId,
        'topicId': topicId,
      }),
    );
    if (response.statusCode == 200) {
      print('Topic created successfully.');
    } else {
      print('Server responded with status code: ${response.statusCode}');
      throw Error();
    }
  }

  static Future<List<SearchTopic>> topicSearch(String title) async {
    final url = Uri.parse('$baseUrl/topic-service/search?title=$title');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      final List<int> bytes = response.bodyBytes;
      final String responseBody = utf8.decode(bytes);
      final List<dynamic> searchTopic = jsonDecode(responseBody);
      print(searchTopic);
      return searchTopic.map((item) => SearchTopic.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
