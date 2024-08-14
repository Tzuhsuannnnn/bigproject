import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:view/models/Video.dart';

class Video_SVS {

  Future<void> createVideo(String name, String url) async {
    final apiUrl = Uri.parse('http://192.168.1.113:8080/api/video/create');
    final response = await http.post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': name,
        'url': url,
      }),
    );

    if (response.statusCode == 201) {
      print('Video created successfully: ${response.body}');
    } else {
      print('Failed to create video: ${response.statusCode}');
    }
  }

  Future<void> getVideoById(String videoId) async {
    final apiUrl = Uri.parse('http://192.168.1.113:8080/VideoController/get?video_id=20');
    final response = await http.get(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final content = jsonDecode(response.body);
      print('Video retrieved successfully: ${content["response"]}');
    } else {
      print('Failed to retrieve video: ${response.statusCode}');
    }
  }


  Future<void> searchAndCreateVideos(String keyword, int maxResults) async {
    final apiUrl = Uri.parse('http://192.168.1.113:8080/api/video/search_and_create');
    final response = await http.post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'keyword': keyword,
        'max_results': maxResults,
      }),
    );

    if (response.statusCode == 200) {
      final content = jsonDecode(response.body);
      print('Videos searched and created successfully: ${content["created_videos"]}');
    } else {
      print('Failed to search and create videos: ${response.statusCode}');
    }
  }
}