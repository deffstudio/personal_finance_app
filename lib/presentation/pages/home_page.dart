import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_app/core/services/service_locator.dart';
import 'package:personal_finance_app/presentation/bloc/transaction_list/transaction_list_bloc.dart';
import 'package:personal_finance_app/presentation/widgets/transaction_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("🏠 [UI] Membangun HomePage...");
    // Pro Tip: Provide the Bloc at the top of the page
    return BlocProvider(
      create: (context) =>
          sl<TransactionListBloc>()..add(const LoadTransactions()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Finance'),
          centerTitle: true,
        ),
        body: const TransactionListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Placeholder for Module 5
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Add Transaction coming in Module 5!")),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
