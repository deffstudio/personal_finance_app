import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_app/core/services/service_locator.dart';
import 'package:personal_finance_app/presentation/bloc/transaction_list/transaction_list_bloc.dart';
import 'package:personal_finance_app/presentation/widgets/transaction_list_view.dart';
import 'package:personal_finance_app/presentation/pages/add_transaction_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("🏠 [UI] Membangun HomePage...");
    // Pro Tip: Provide the Bloc at the top of the page
    return BlocProvider(
      create: (context) =>
          sl<TransactionListBloc>()..add(const LoadTransactions()),
      child: Builder(
        builder: (BuildContext newContext) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Personal Finance'),
              centerTitle: true,
            ),
            body: const TransactionListView(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Navigation
                Navigator.of(newContext).push(
                  MaterialPageRoute(
                    // We need to pass the EXISTING BloC to the new page
                    // so it can send the 'AddTransaction' event.
                    builder: (_) => BlocProvider.value(
                      value: newContext.read<TransactionListBloc>(),
                      child: const AddTransactionPage(),
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
