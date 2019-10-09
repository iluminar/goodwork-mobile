import 'dart:convert';

import 'package:goodwork/models/task.dart';
import 'package:goodwork/repositories/base_repository.dart';
import 'package:http/http.dart' as http;

class TaskRepository extends BaseRepository {
  Future<List> getUserCurrentTask() async {
    final String baseUrl = await getBaseUrl();
    final String accessToken = await getAccessToken();
    final String url = '$baseUrl/api/home';
    final http.StreamedResponse streamedResponse =
        await client.send(http.Request('GET', Uri.parse(url))
          ..headers['content-type'] = 'application/json'
          ..headers['authorization'] = 'Bearer $accessToken');
    final http.Response response =
        await http.Response.fromStream(streamedResponse);
    final List body = await json.decode(response.body)['current_work'];

    return body.map<Task>((dynamic item) => Task.fromJson(item)).toList();
  }
}
