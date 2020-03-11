import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> endpointGet(String url, int port, String request) async {
  final uri = Uri.http("$url:$port", "$request");
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  } catch (e) {
    print("Error in ${endpointGet}");
  }
}

Future<dynamic> endpointPost(String url, int port, String request, map) async {
  final uri = Uri.http("$url:$port", "$request");
  try {
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: json.encode(map));
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  } catch (e) {
    print("Error in ${endpointPost}");
  }
}
