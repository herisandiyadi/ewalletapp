import 'package:ewallet_app/cubit/history/history_cubit.dart';
import 'package:ewallet_app/shared/shared_methods.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  void getHistory() {
    context.read<HistoryCubit>().getHistory();
  }

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orangeCOlor,
        title: const Text('History Transaksi'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HistoryLoaded) {
              final data = state.transactionHistory.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  formatCurrency(data[index].amount),
                                  style: blackTextStyle.copyWith(
                                      fontSize: 16, fontWeight: semiBold),
                                )),
                                Column(
                                  children: [
                                    data[index].transactionType == "transfer"
                                        ? const Icon(Icons.sync_alt)
                                        : const Icon(Icons.wallet),
                                    Text(data[index].transactionType),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              data[index].transactionTime.toString(),
                              style: greyTextStyle.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text('Data Kosong'),
            );
          },
        ),
      ),
    );
  }
}
