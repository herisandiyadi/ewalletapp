import 'dart:convert';

import 'package:ewallet_app/models/login_request.dart';
import 'package:ewallet_app/models/response_login.dart';
import 'package:ewallet_app/shared/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

abstract class LoginRepositoryImpl {
  Future<ResponseLogin> login(LoginRequest request);
}

class LoginRepository implements LoginRepositoryImpl {
  @override
  Future<ResponseLogin> login(LoginRequest request) async {
    const storage = FlutterSecureStorage();
    final body = {"email": request.email, "password": request.password};
    final response = await http.post(Uri.parse('${baseUrl}login'), body: body);
    final jsonResult = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final json = ResponseLogin.fromJson(jsonResult);
      await storage.write(
        key: 'jwt',
        value: json.data.token,
        aOptions: const AndroidOptions(),
      );
      await storage.write(
        key: 'firstNm',
        value: json.data.firstName,
        aOptions: const AndroidOptions(),
      );
      await storage.write(
        key: 'lastNm',
        value: json.data.lastName,
        aOptions: const AndroidOptions(),
      );

      return json;
    }
    throw Exception(jsonResult['message']);
  }
}
