import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:piggai/component/transaction/transaction_container.dart';
import 'package:piggai/component/transaction/transaction_list_by_day.dart';
import 'package:piggai/component/transaction/transaction_modal_bottom.dart';
import 'package:piggai/component/transaction/transaction_summary_card.dart';
import 'package:piggai/controller/transaction_controller.dart';
import 'package:piggai/util/date_util.dart';

class TransactionPage extends StatelessWidget {
  TransactionPage({super.key});
  final _controller = TransactionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Minhas finanças"),),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        spaceBetweenChildren: 10,
        label: Text("Criar finança"),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.attach_money),
            label: 'Receita',
            onTap: () {
              TransactionModalBottom().show(context, _controller, "income");
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.money_off),
            label: 'Despesa',
            onTap: () {
              TransactionModalBottom().show(context, _controller, "expense");
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: _controller.initialize(context),
          builder: (context, snapshot) {
            return Observer(
              builder: (context) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TransactionSummaryCard(expense: 200,income: 100,),
                      for(int i = 0; i < _controller.datesOfTransactions.length; i++)
                        TransactionListByDay(dateTime: _controller.datesOfTransactions[i], controller: _controller),
                      SizedBox(height: 80,)
                    ],
                  ),
                );
              }
            );
          },
      ),
    );
  }

}
