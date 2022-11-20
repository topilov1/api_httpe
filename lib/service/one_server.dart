import 'dart:convert';

import 'package:api_httpe/models/post.dart';
import 'package:http/http.dart' as http;

class OneService {
  String bossUrl = 'https://636497347b209ece0f495343.mockapi.io';

// get
  Future<List<Odam>?> getPost() async {
    var client = http.Client();
    var uri = Uri.parse('$bossUrl/odam');
    var risponse = await client.get(uri);

    if (risponse.statusCode == 200) {
      var json = risponse.body;
      return odamFromJson(json);
    }
    return null;
  }

// post
  Future<Odam?> post(Odam psot) async {
    var client = http.Client();
    var uri = Uri.parse('$bossUrl/odam');
    var risponse = await client.post(uri, body: {
      "name": psot.name,
    });
    if (risponse.statusCode == 200) {
      return Odam.fromJson(jsonDecode(risponse.body));
    }
    return null;
  }

  static Future<Odam?> put(Odam psot) async {
    String bossUrl = 'https://636497347b209ece0f495343.mockapi.io';
    var client = http.Client();
    var uri = Uri.parse('$bossUrl/odam/${psot.id}');
    var risponse = await client.put(uri, body: {
      "name": psot.name,
    });
    if (risponse.statusCode == 200) {
      return Odam.fromJson(jsonDecode(risponse.body));
    }
    return null;
  }

// delete
  static delete(Odam psot) async {
    String bossUrl = 'https://636497347b209ece0f495343.mockapi.io';
    var client = http.Client();
    var uri = Uri.parse('$bossUrl/odam/${psot.id}');
    await client.delete(uri);
  }
}
