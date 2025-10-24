import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:piggai/component/category/category_circle.dart';
import 'package:piggai/component/transaction/transaction_container.dart';
import 'package:piggai/component/transaction/transaction_modal_bottom.dart';
import 'package:piggai/controller/transaction_controller.dart';
import 'package:piggai/util/color_util.dart';

class TransactionPage extends StatelessWidget {
  TransactionPage({super.key});
  final _controller = TransactionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        spaceBetweenChildren: 10,
        label: Text("Criar finança"),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Bordas menos arredondadas
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
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Filtrar categoria"),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 10,
                              children: [
                                for(int i = 0; i < _controller.categories.length; i++)
                                  CategoryCircle(
                                    category: _controller.categories[i],
                                    isSelected: _controller.categoryFilterSelected[_controller.categories[i]],
                                    onTap: () => _controller.setCategoryFilter(_controller.categories[i]),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: _controller.transactionsFiltered.length,
                          itemBuilder: (context, index) {
                            return TransactionContainer(
                                transaction: _controller.transactionsFiltered[index],
                                controller: _controller
                            );
                          },
                        )
                    )
                  ],
                );
              }
            );
          },
      ),
    );
  }
}
