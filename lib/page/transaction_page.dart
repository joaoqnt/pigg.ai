import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:piggai/component/bottom_navigation_component/modal_bottom_component.dart';
import 'package:piggai/component/month_dropdown.dart';
import 'package:piggai/component/transaction/transaction_list_by_day.dart';
import 'package:piggai/component/transaction/transaction_list_category.dart';
import 'package:piggai/component/transaction/transaction_summary_card.dart';
import 'package:piggai/controller/transaction_controller.dart';

class TransactionPage extends StatelessWidget {
  TransactionPage({super.key});
  final _controller = TransactionController();

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          title: Text("Finanças"),
          // bottom: Tab(child: ),
          actions: [
            InkWell(
              onTap: () => ModalBottomComponent().show(context,onlyTransaction: true,transactionController: _controller),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle
                ),
                child: Icon(Icons.add,color: colorScheme.onPrimary,),
              ),
            )
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
                      MonthDropdown(
                          monthMap: _controller.mapFilterDateTransaction,
                          onChanged: (p0) => _controller.setDateFilter(p0!)
                      ),
                      SizedBox(height: 8),
                      TransactionListCategory(controller: _controller),
                      SizedBox(height: 8),
                      TransactionSummaryCard(
                        expense: _controller.mapAmountIncExp["expense"]??0,
                        income: _controller.mapAmountIncExp["income"]??0,
                      ),
                      for(int i = 0; i < _controller.datesOfTransactions.length; i++)
                        TransactionListByDay(dateTime: _controller.datesOfTransactions[i], controller: _controller),
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
