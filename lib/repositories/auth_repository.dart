import 'dart:convert';

import 'package:goodwork/repositories/base_repository.dart';
import 'package:http/http.dart' as http;

class AuthRepository extends BaseRepository {
  Future<http.Response> sendTokenRequest(String email, String password) async {
    final String baseUrl = await getBaseUrl();
    final String url = '$baseUrl/oauth/token';
    http.StreamedResponse response;
    response = await client.send(http.Request('POST', Uri.parse(url))
      ..headers['content-type'] = 'application/json'
      ..body = jsonEncode({
        'username': email,
        'password': password,
      }));

    return await http.Response.fromStream(response);
  }

  Future<Map<String, dynamic>> getAuthUser() async {
    final String baseUrl = await getBaseUrl();
    final String accessToken = await getAccessToken();
    final String url = '$baseUrl/api/me';
    final http.StreamedResponse streamedResponse =
        await client.send(http.Request('GET', Uri.parse(url))
          ..headers['content-type'] = 'application/json'
          ..headers['authorization'] = 'Bearer $accessToken');
    final http.Response response =
        await http.Response.fromStream(streamedResponse);
    return await json.decode(response.body);
  }
}
