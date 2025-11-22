import 'package:personal_finance_app/domain/entities/transaction_entity.dart';

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

class AddTransaction extends TransactionListEvent {
  final TransactionEntity transaction;

  const AddTransaction(this.transaction);

  @override
  List<Object> get props => [transaction];
}