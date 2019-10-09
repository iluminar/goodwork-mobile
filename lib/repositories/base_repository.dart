import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseRepository {
  SharedPreferences prefs;
  final http.Client client = http.Client();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String> getBaseUrl() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString('base_url');
  }

  Future<String> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }
}
