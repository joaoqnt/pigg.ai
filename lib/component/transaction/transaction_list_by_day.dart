import 'package:flutter/material.dart';
import 'package:piggai/component/transaction/transaction_container.dart';
import 'package:piggai/controller/transaction_controller.dart';
import 'package:piggai/model/transaction_model.dart';
import 'package:piggai/util/date_util.dart';

class TransactionListByDay extends StatelessWidget {
  final DateTime dateTime;
  final TransactionController controller;

  const TransactionListByDay({
    super.key,
    required this.dateTime,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    List<TransactionModel> transactions = controller.transactionsFiltered.where((element) => element.date == dateTime,).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text("${DateUtil.dayOfWeekName(dateTime)}, ${dateTime.day.toString().padLeft(2,'0')}",
            style: TextStyle(fontWeight: FontWeight.w500)
          ),
        ),
        for(int i = 0; i < transactions.length; i++)
          TransactionContainer(transaction: transactions[i], controller: controller)
      ],
    );
  }
}
