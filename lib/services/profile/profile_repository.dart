import 'dart:convert';

import 'package:ewallet_app/models/profile_response.dart';
import 'package:ewallet_app/models/update_request.dart';
import 'package:ewallet_app/models/update_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../shared/constants.dart';

abstract class ProfileRepositoryImpl {
  Future<ProfileResponse> getProfile();
  Future<UpdateResponse> updateProfile(UpdateRequest request);
}

class ProfileRepository implements ProfileRepositoryImpl {
  final storage = const FlutterSecureStorage();
  @override
  Future<ProfileResponse> getProfile() async {
    final token = await storage.read(key: 'jwt');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token',
    };

    final response =
        await http.get(Uri.parse('${baseUrl}getProfile'), headers: headers);
    final jsonResult = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final json = ProfileResponse.fromJson(jsonResult);
      return json;
    }
    throw Exception(jsonResult['message']);
  }

  @override
  Future<UpdateResponse> updateProfile(UpdateRequest request) async {
    final token = await storage.read(key: 'jwt');
    final headers = {
      "Authorization": 'Bearer $token',
    };

    final body = {
      "first_name": request.firstName,
      "last_name": request.lastName
    };

    final response = await http.post(Uri.parse('${baseUrl}updateProfile'),
        headers: headers, body: body);
    final jsonResult = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final json = UpdateResponse.fromJson(jsonResult);
      return json;
    }
    throw Exception(jsonResult['message']);
  }
}
