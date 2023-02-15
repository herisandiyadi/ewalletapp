part of 'balance_cubit.dart';

abstract class BalanceState extends Equatable {
  const BalanceState();

  @override
  List<Object> get props => [];
}

class BalanceInitial extends BalanceState {}

class BalanceLoading extends BalanceState {}

class BalanceLoaded extends BalanceState {
  final ResponseBalance responseBalance;
  const BalanceLoaded(this.responseBalance);

  @override
  List<Object> get props => [responseBalance];
}

class BalanceFailed extends BalanceState {
  final String message;
  const BalanceFailed(this.message);

  @override
  List<Object> get props => [message];
}
