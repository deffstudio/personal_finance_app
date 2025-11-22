import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/transaction_list/transaction_list_bloc.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionListBloc, TransactionListState>(
        builder: (context, state) {
      // State 1: Loading
      if (state is TransactionListLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // State 2: Loaded (Success)
      else if (state is TransactionListLoaded) {
        if (state.transactions.isEmpty) {
          return const Center(child: Text("No transactions yet. Add one!"));
        }
        return ListView.builder(
            itemCount: state.transactions.length,
            itemBuilder: (context, index) {
              final transaction = state.transactions[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: transaction.isExpense
                      ? Colors.red[100]
                      : Colors.green[100],
                  child: Icon(
                    transaction.isExpense
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                    color: transaction.isExpense ? Colors.red : Colors.green,
                  ),
                ),
                title: Text(transaction.description ?? 'No Description'),
                subtitle: Text(transaction.date.toString().split('')[0]),
                trailing: Text(
                  '${transaction.isExpense ? '-' : '+'}\Rp${transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: transaction.isExpense ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            });
      }

      // State 3: Error
      else if (state is TransactionListError) {
        return Center(
          child: Text('Error: ${state.message}'),
        );
      }

      // State 4: Initial (Shouldn't happen long if event added in provider)
      return const SizedBox.shrink();
    });
  }
}
