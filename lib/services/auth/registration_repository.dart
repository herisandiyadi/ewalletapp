import 'dart:convert';

import 'package:ewallet_app/models/registration_response.dart';
import 'package:ewallet_app/models/request_registrasi.dart';
import 'package:http/http.dart' as http;

import '../../shared/constants.dart';

abstract class RegistrationRepositoryImpl {
  Future<ResponseRegistration> registrasi(RequestRegistrasi request);
}

class RegistrationRepository implements RegistrationRepositoryImpl {
  @override
  Future<ResponseRegistration> registrasi(RequestRegistrasi request) async {
    final body = {
      "email": request.email,
      "password": request.password,
      "first_name": request.firstName,
      "last_name": request.lastName,
    };
    final response =
        await http.post(Uri.parse('${baseUrl}registration'), body: body);

    final jsonResult = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final json = ResponseRegistration.fromJson(jsonResult);
      return json;
    }
    throw Exception(jsonResult['message']);
  }
}
