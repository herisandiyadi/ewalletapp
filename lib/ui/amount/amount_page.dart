import 'package:ewallet_app/cubit/transaction/transaction_cubit.dart';
import 'package:ewallet_app/ui/amount/input_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../shared/loading_widget.dart';
import '../../shared/theme.dart';

class AmountPage extends StatefulWidget {
  final String title;
  const AmountPage({super.key, required this.title});

  @override
  State<AmountPage> createState() => _AmountPageState();
}

class _AmountPageState extends State<AmountPage> {
  final TextEditingController amountController =
      TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    amountController.addListener(() {
      final text = amountController.text;
      amountController.value = amountController.value.copyWith(
        text: NumberFormat.currency(
          locale: 'id',
          decimalDigits: 0,
          symbol: '',
        ).format(
          int.parse(text.replaceAll('.', '')),
        ),
      );
    });
  }

  addAmount(String number) {
    if (amountController.text == '0') {
      amountController.text = '';
    }
    setState(() {
      amountController.text = amountController.text + number;
    });
  }

  deleteAmount() {
    if (amountController.text.isNotEmpty) {
      setState(() {
        amountController.text = amountController.text
            .substring(0, amountController.text.length - 1);
        if (amountController.text == '') {
          amountController.text = '0';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkbgColor,
      appBar: AppBar(
        backgroundColor: darkbgColor,
        title: Text(
          widget.title,
          style: whiteTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocListener<TransactionCubit, TransactionState>(
        listener: (context, state) {
          if (state is TransactionLoading) {
            LoadingWidget(context).loading(true);
          } else if (state is TopupLoaded) {
            LoadingWidget(context).loading(false);
            Alert(
              context: context,
              type: AlertType.success,
              title: "Success",
              desc: state.transactionResponse.message,
              buttons: [
                DialogButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  },
                  width: 120,
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ).show();
          } else if (state is TransferLoaded) {
            LoadingWidget(context).loading(false);
            Alert(
              context: context,
              type: AlertType.success,
              title: "Success",
              desc: state.transactionResponse.message,
              buttons: [
                DialogButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  },
                  width: 120,
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ).show();
          } else if (state is TransactionFailed) {
            Alert(
              context: context,
              type: AlertType.error,
              title: "Failed",
              desc: state.message,
              buttons: [
                DialogButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  },
                  width: 120,
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ).show();
          }
        },
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: SizedBox(
                  child: TextFormField(
                    enabled: false,
                    controller: amountController,
                    keyboardType: TextInputType.none,
                    cursorColor: greyColor,
                    style: whiteTextStyle.copyWith(
                        fontSize: 36, fontWeight: medium, letterSpacing: 5),
                    decoration: InputDecoration(
                      prefixIcon: Text(
                        'Rp. ',
                        style: whiteTextStyle.copyWith(
                            fontSize: 36, fontWeight: medium),
                      ),
                      disabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: greyColor),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: greyColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Wrap(
                  spacing: 40,
                  runSpacing: 40,
                  children: [
                    InputNumber(
                        label: '1',
                        onPressed: () {
                          addAmount('1');
                        }),
                    InputNumber(
                        label: '2',
                        onPressed: () {
                          addAmount('2');
                        }),
                    InputNumber(
                        label: '3',
                        onPressed: () {
                          addAmount('3');
                        }),
                    InputNumber(
                        label: '4',
                        onPressed: () {
                          addAmount('4');
                        }),
                    InputNumber(
                        label: '5',
                        onPressed: () {
                          addAmount('5');
                        }),
                    InputNumber(
                        label: '6',
                        onPressed: () {
                          addAmount('6');
                        }),
                    InputNumber(
                        label: '7',
                        onPressed: () {
                          addAmount('7');
                        }),
                    InputNumber(
                        label: '8',
                        onPressed: () {
                          addAmount('8');
                        }),
                    InputNumber(
                        label: '9',
                        onPressed: () {
                          addAmount('9');
                        }),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: darkbgColor),
                    ),
                    InputNumber(
                        label: '0',
                        onPressed: () {
                          addAmount('0');
                        }),
                    GestureDetector(
                      onTap: () {
                        deleteAmount();
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: greyColor),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    final amount = amountController.text.replaceAll(
                      '.',
                      '',
                    );
                    if (int.parse(amount) <= 1000) {
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "Failed",
                        desc: 'Transaksi tidak dapat di bawah Rp. 1000',
                        buttons: [
                          DialogButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            width: 120,
                            child: const Text(
                              "OK",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ],
                      ).show();
                    } else {
                      widget.title == 'Top Up'
                          ? context
                              .read<TransactionCubit>()
                              .topup(amountController.text.replaceAll(
                                '.',
                                '',
                              ))
                          : context
                              .read<TransactionCubit>()
                              .transfer(amountController.text.replaceAll(
                                '.',
                                '',
                              ));
                    }
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(orangeCOlor)),
                  child: Text(
                    'Submit',
                    style: whiteTextStyle.copyWith(
                        fontSize: 18, fontWeight: semiBold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
