part of 'transaction_cubit.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransferLoaded extends TransactionState {
  final TransactionResponse transactionResponse;
  const TransferLoaded(this.transactionResponse);

  @override
  List<Object> get props => [transactionResponse];
}

class TopupLoaded extends TransactionState {
  final TransactionResponse transactionResponse;
  const TopupLoaded(this.transactionResponse);

  @override
  List<Object> get props => [transactionResponse];
}

class TransactionFailed extends TransactionState {
  final String message;
  const TransactionFailed(this.message);

  @override
  List<Object> get props => [message];
}
