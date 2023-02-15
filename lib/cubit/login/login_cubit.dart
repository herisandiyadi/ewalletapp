import 'package:ewallet_app/models/login_request.dart';
import 'package:ewallet_app/models/response_login.dart';
import 'package:ewallet_app/services/auth/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;
  LoginCubit(this.loginRepository) : super(LoginInitial());

  Future<void> login(LoginRequest request) async {
    emit(LoginLoading());
    try {
      final response = await loginRepository.login(request);

      emit(LoginLoaded(response));
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(LoginLoading());
      var storage = const FlutterSecureStorage();
      storage.deleteAll(aOptions: const AndroidOptions());
      emit(LoginInitial());
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }
}
