import 'package:equatable/equatable.dart';
import 'package:ewallet_app/models/registration_response.dart';
import 'package:ewallet_app/models/request_registrasi.dart';
import 'package:ewallet_app/services/auth/registration_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegistrationRepository registrationRepository;
  RegisterCubit(this.registrationRepository) : super(RegisterInitial());

  Future<void> register(RequestRegistrasi requestRegistrasi) async {
    emit(RegisterLoading());
    try {
      final response =
          await registrationRepository.registrasi(requestRegistrasi);
      emit(RegisterLoaded(response));
    } catch (e) {
      emit(RegisterFailed(e.toString()));
    }
  }
}
