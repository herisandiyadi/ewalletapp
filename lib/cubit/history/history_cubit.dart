import 'package:ewallet_app/models/transaction_history.dart';
import 'package:ewallet_app/services/history/history_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository historyRepository;
  HistoryCubit(this.historyRepository) : super(HistoryInitial());

  Future<void> getHistory() async {
    emit(HistoryLoading());
    try {
      final result = await historyRepository.getHistory();
      emit(HistoryLoaded(result));
    } catch (e) {
      emit(HistoryFailed(e.toString()));
    }
  }
}
