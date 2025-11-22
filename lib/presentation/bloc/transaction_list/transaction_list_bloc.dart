import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_finance_app/domain/entities/transaction_entity.dart';
import 'package:personal_finance_app/domain/repositories/transaction_repository.dart';

part 'transaction_list_event.dart';
part 'transaction_list_state.dart';

class TransactionListBloc
    extends Bloc<TransactionListEvent, TransactionListState> {
  final TransactionRepository repository;

  TransactionListBloc(this.repository) : super(TransactionListInitial()) {
    // Event Handler
    on<LoadTransactions>(_onLoadTransactions);
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionListState> emit,
  ) async {
    emit(TransactionListLoading());

    try {
      // Pro Tip: emit.forEach automatically subscribes to the Stream
      // and handles cancellations when the Bloc is closed.
      await emit.forEach<List<TransactionEntity>>(
        repository.getTransactions(),
        onData: (transactions) => TransactionListLoaded(transactions),
        onError: (_, __) =>
            const TransactionListError('Failed to load transactions'),
      );
    } catch (e) {
      emit(TransactionListError(e.toString()));
    }
  }
}
