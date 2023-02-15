part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  final ResponseRegistration responseRegistration;
  const RegisterLoaded(this.responseRegistration);

  @override
  List<Object> get props => [responseRegistration];
}

class RegisterFailed extends RegisterState {
  final String message;
  const RegisterFailed(this.message);

  @override
  List<Object> get props => [message];
}
