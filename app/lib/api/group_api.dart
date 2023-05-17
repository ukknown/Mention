// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'group_model.dart';
// import 'dart:convert' show jsonDecode, utf8;

// final String baseUrl = 'http://k8c105.p.ssafy.io:8000';
// final String token =
//     'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJqb25rdWtAZ21haWwuY29tIiwiZW1haWwiOiJqb25rdWtAZ21haWwuY29tIiwibmlja25hbWUiOiLstZzsooXsmrEiLCJpYXQiOjE2ODQyMzgwMTUsImV4cCI6MTY4NjgzMDAxNX0.9sk-d3ghnJk7C_aI7Bx-9ProSaDFV7aZ3F_t9DY8cl3stS6Aetz79UfmS2pyjW0DAu5NaLwRSgKdHIAxLn1Tbw';
// late int propsId;

// Future<GroupDetailModel> fetchGroupData() async {
//   final response = await http.get(
//     Uri.parse(
//         '$baseUrl/team-service/teams/${propsId}'), // Replace 'YOUR_ENDPOINT' with the correct endpoint.
//     headers: {
//       'Authorization': 'Bearer $token',
//     },
//   );

//   if (response.statusCode == 200) {
//     String body = utf8.decode(response.bodyBytes);
//     return GroupDetailModel.fromJson(jsonDecode(body));
//   } else {
//     throw Exception('Failed to load group data');
//   }
// }
