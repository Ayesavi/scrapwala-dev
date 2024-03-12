import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Abstract class for API service
abstract class BaseApiService {
  Future<Response> fetch(String endpoint);
  Future<Response> post(String endpoint, Map<String, dynamic> data);
}

enum ApiEndpoints {
  requestPickup('/requestPickup'),
  createTranscationRequest('/createTranscationRequest');

  const ApiEndpoints(this.route);
  final String route;
}

// Implementation of ApiService using Dio
class ApiService implements BaseApiService {
  late final Dio _dio;

  String url = 'https://scrapwala-dev.ayesavi.workers.dev/api/v1';
  final headers = {
    'accept': 'application/json',
    'Authorization':
        'Bearer ${Supabase.instance.client.auth.currentSession?.accessToken}',
    'Content-Type': 'application/json',
  };

  ApiService() {
    _dio = Dio();
  }
  @override
  Future<Response> fetch(String endpoint) async {
    try {
      return await _dio.get(endpoint);
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  @override
  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('$url$endpoint',
          data: jsonEncode(data), options: Options(headers: headers));  
      return response;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}
