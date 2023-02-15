import 'dart:convert';

import 'package:ewallet_app/models/topup_response.dart';
import 'package:ewallet_app/shared/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

abstract class TransactionRepositoryImpl {
  Future<TransactionResponse> topup(String amount);
  Future<TransactionResponse> transfer(String amount);
}

class TransactionRepository implements TransactionRepositoryImpl {
  final storage = const FlutterSecureStorage();
  @override
  Future<TransactionResponse> topup(String amount) async {
    final token = await storage.read(key: 'jwt');
    final headers = {
      "Authorization": 'Bearer $token',
    };
    final body = {"amount": amount};

    final response = await http.post(Uri.parse('$baseUrl/topup'),
        headers: headers, body: body);

    final jsonResult = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final json = TransactionResponse.fromJson(jsonResult);

      return json;
    }
    throw Exception(jsonResult['message']);
  }

  @override
  Future<TransactionResponse> transfer(String amount) async {
    final token = await storage.read(key: 'jwt');
    final headers = {
      "Authorization": 'Bearer $token',
    };
    final body = {"amount": amount};

    final response = await http.post(Uri.parse('$baseUrl/transfer'),
        headers: headers, body: body);

    final jsonResult = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final json = TransactionResponse.fromJson(jsonResult);

      return json;
    }
    throw Exception(jsonResult['message']);
  }
}
