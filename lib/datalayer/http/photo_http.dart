import 'dart:convert';
import 'package:baby/datalayer/model/photo_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const String photoBaseURL = 'https://jsonplaceholder.typicode.com/photos';

/// fetch photo by ID
Future<Photo> fetchPhotoByID(String id) async {
  final response = await http.get(Uri.parse('$photoBaseURL/$id'));

  if (response.statusCode == 200) {
    return Photo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Photo');
  }
}

/// fetch list photos
Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(Uri.parse('$photoBaseURL?_limit=100'));
  return compute(parsePhotos, response.body);
}

/// converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}
