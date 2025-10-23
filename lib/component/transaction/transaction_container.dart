import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:piggai/component/category/category_modal_bottom.dart';
import 'package:piggai/component/custom_blur_dialog.dart';
import 'package:piggai/component/custom_container.dart';
import 'package:piggai/component/dialog/custom_delete_dialog.dart';
import 'package:piggai/controller/category_controller.dart';
import 'package:piggai/controller/transaction_controller.dart';
import 'package:piggai/model/category_model.dart';
import 'package:piggai/model/transaction_model.dart';
import 'package:piggai/util/color_util.dart';
import 'package:piggai/util/date_util.dart';

class TransactionContainer extends StatelessWidget {
  final TransactionModel transaction;
  final TransactionController controller;

  const TransactionContainer({
    super.key,
    required this.transaction,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Slidable(
          key: ValueKey(transaction.id),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.2,
            children: [
              SlidableAction(
                onPressed: (_) {
                  // CategoryModalBottom().show(context, controller, category: category);
                },
                backgroundColor: Color(0xFFFBFBFB),
                icon: Icons.edit_outlined,
              ),
              SlidableAction(
                onPressed: (_) async {
                  CustomDeleteDialog.show(
                      context,
                      onPressed: () {
                        Navigator.pop(context);
                        // controller.alterCategory(category: category,isDelete: true);
                      }
                  );
                },
                backgroundColor: Colors.redAccent.shade200,
                icon: Icons.delete_outline,
              ),
            ],
          ),
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                // ação ao tocar
              },
              onLongPress: () {
                CustomBlurDialog.show(
                  context: context,
                  mainContent: TransactionContainer(
                    transaction: transaction,
                    controller: controller,
                  ),
                  options: [
                    BlurDialogOption(
                      label: 'Editar',
                      icon: Icons.edit,
                      iconColor: Colors.black54,
                      onTap: () {
                        // CategoryModalBottom().show(context, controller, category: category);
                      },
                    ),
                    BlurDialogOption(
                      label: 'Excluir',
                      icon: Icons.delete,
                      iconColor: Colors.redAccent,
                      onTap: () {
                        CustomDeleteDialog.show(
                          context,
                          onPressed: () {
                            Navigator.pop(context);
                            // controller.alterCategory(category: category,isDelete: true);
                          },
                        );
                      },
                    ),
                  ],
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Row(
                  spacing: 10,
                  children: [
                    CustomContainer(
                      backgroundColor: ColorUtil().formatColor(transaction.category.color),
                      iconColor: ColorUtil().darken(ColorUtil().formatColor(transaction.category.color), 0.3),
                      isLoading: controller.isDeleting[transaction],
                      iconData: transaction.type == "income" ? Icons.attach_money : Icons.money_off,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.description,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            DateUtil.formatDateTime(transaction.date),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      decoration: BoxDecoration(
                        color: transaction.type == 'income' ? Colors.green.shade50 : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text(UtilBrasilFields.obterReal(transaction.amount),
                        style: TextStyle(
                            color: transaction.type == 'income' ? Colors.green : Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
