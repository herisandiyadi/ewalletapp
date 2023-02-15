import 'package:ewallet_app/models/topup_response.dart';
import 'package:ewallet_app/services/transaction/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepository transactionRepository;
  TransactionCubit(this.transactionRepository) : super(TransactionInitial());

  Future<void> topup(String amount) async {
    emit(TransactionLoading());
    try {
      final response = await transactionRepository.topup(amount);
      emit(TopupLoaded(response));
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }

  Future<void> transfer(String amount) async {
    emit(TransactionLoading());
    try {
      final response = await transactionRepository.transfer(amount);
      emit(TransferLoaded(response));
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }
}
