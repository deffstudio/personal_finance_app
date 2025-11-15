part of 'transaction_list_bloc.dart';

sealed class TransactionListEvent extends Equatable {
  const TransactionListEvent();

  @override
  List<Object> get props => [];
}

class LoadTransactions extends TransactionListEvent {
  // This event might trigger filters later (e.g. by date),
  // but for now it's empty.
  const LoadTransactions();
}
