import 'package:ewallet_app/models/response_balance.dart';
import 'package:ewallet_app/services/saldo/balance_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  final BalanceRepository balanceRepository;
  BalanceCubit(this.balanceRepository) : super(BalanceInitial());

  Future<void> getSaldo() async {
    emit(BalanceLoading());
    try {
      final result = await balanceRepository.getSaldo();
      emit(BalanceLoaded(result));
    } catch (e) {
      emit(BalanceFailed(e.toString()));
    }
  }
}
