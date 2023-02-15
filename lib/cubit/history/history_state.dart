part of 'history_cubit.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final TransactionHistory transactionHistory;
  const HistoryLoaded(this.transactionHistory);

  @override
  List<Object> get props => [transactionHistory];
}

class HistoryFailed extends HistoryState {
  final String message;
  const HistoryFailed(this.message);

  @override
  List<Object> get props => [message];
}
