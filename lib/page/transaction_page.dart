import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:piggai/component/bottom_navigation_component/modal_bottom_component.dart';
import 'package:piggai/component/custom/button/custom_small_add_button.dart';
import 'package:piggai/component/custom/month_dropdown.dart';
import 'package:piggai/component/custom/search_text_form_field.dart';
import 'package:piggai/component/transaction/transaction_list_by_day.dart';
import 'package:piggai/component/transaction/transaction_list_category.dart';
import 'package:piggai/component/transaction/transaction_summary_card.dart';
import 'package:piggai/controller/category_controller.dart';
import 'package:piggai/controller/transaction_controller.dart';
import 'package:piggai/util/singleton.dart';

class TransactionPage extends StatelessWidget {

  TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Singleton().transactionController;
    return Scaffold(
        appBar: AppBar(
          title: Text("Finanças"),
          bottom: Tab(child: SearchTextFormField(controller: controller.tecSearch)),
          actions: [
            CustomSmallAddButton(
                onTap: () => ModalBottomComponent().show(context,transactionController: controller,onlyTransaction: true)
            )
          ],
        ),
        body: FutureBuilder(
          future: controller.initialize(context),
          builder: (context, snapshot) {
            return Observer(
              builder: (context) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MonthDropdown(
                          monthMap: controller.mapFilterDateTransaction,
                          onChanged: (p0) => controller.setDateFilter(p0!)
                      ),
                      SizedBox(height: 8),
                      TransactionListCategory(controller: controller),
                      SizedBox(height: 8),
                      TransactionSummaryCard(
                        expense: controller.mapAmountIncExp["expense"]??0,
                        income: controller.mapAmountIncExp["income"]??0,
                      ),
                      for(int i = 0; i < controller.datesOfTransactions.length; i++)
                        TransactionListByDay(dateTime: controller.datesOfTransactions[i], controller: controller),
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
