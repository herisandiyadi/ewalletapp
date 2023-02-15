import 'dart:convert';

import 'package:ewallet_app/models/response_balance.dart';
import 'package:ewallet_app/shared/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

abstract class BalanceRepositoryImpl {
  Future<ResponseBalance> getSaldo();
}

class BalanceRepository implements BalanceRepositoryImpl {
  final storage = const FlutterSecureStorage();
  @override
  Future<ResponseBalance> getSaldo() async {
    final token = await storage.read(key: 'jwt');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token',
    };

    final response =
        await http.get(Uri.parse('${baseUrl}balance'), headers: headers);
    final jsonResult = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final json = ResponseBalance.fromJson(jsonResult);
      return json;
    }
    throw Exception(jsonResult['message']);
  }
}
