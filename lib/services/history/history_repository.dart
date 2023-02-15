import 'dart:convert';

import 'package:ewallet_app/models/transaction_history.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../shared/constants.dart';

abstract class HistoryRepositoryImpl {
  Future<TransactionHistory> getHistory();
}

class HistoryRepository implements HistoryRepositoryImpl {
  final storage = const FlutterSecureStorage();
  @override
  Future<TransactionHistory> getHistory() async {
    final token = await storage.read(key: 'jwt');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token',
    };
    final response = await http.get(Uri.parse('${baseUrl}transactionHistory'),
        headers: headers);
    final jsonResult = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final json = TransactionHistory.fromJson(jsonResult);
      return json;
    }
    throw Exception(jsonResult['message']);
  }
}
