import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:piggai/component/custom_blur_dialog.dart';
import 'package:piggai/component/custom_container.dart';
import 'package:piggai/component/dialog/custom_delete_dialog.dart';
import 'package:piggai/component/transaction/transaction_modal_bottom.dart';
import 'package:piggai/controller/transaction_controller.dart';
import 'package:piggai/model/transaction_model.dart';
import 'package:piggai/util/color_util.dart';
import 'package:piggai/util/date_util.dart';
import 'package:piggai/util/responsive.dart';

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
            extentRatio: 0.6,
            children: [
              SlidableAction(
                onPressed: (_) {
                  TransactionModalBottom().show(
                    context,
                    controller,
                    transaction.type,
                    transactionClone: transaction,
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                icon: Icons.copy,
                label: 'Duplicar',
              ),
              SlidableAction(
                onPressed: (_) {
                  TransactionModalBottom().show(
                    context,
                    controller,
                    transaction.type,
                    transaction: transaction,
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                icon: Icons.edit_outlined,
                label: 'Editar',
              ),
              SlidableAction(
                onPressed: (_) async {
                  CustomDeleteDialog.show(
                    context,
                    onPressed: () {
                      Navigator.pop(context);
                      controller.alterTransaction(
                        transaction: transaction,
                        isDelete: true,
                      );
                    },
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
                icon: Icons.delete_outline,
                label: 'Excluir',
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              TransactionModalBottom().show(context, controller, transaction.type, transaction: transaction);
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
                    label: 'Duplicar',
                    icon: Icons.copy,
                    iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    onTap: () {
                      TransactionModalBottom().show(context, controller, transaction.type, transactionClone: transaction);
                    },
                  ),
                  BlurDialogOption(
                    label: 'Editar',
                    icon: Icons.edit,
                    iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    onTap: () {
                      TransactionModalBottom().show(context, controller, transaction.type, transaction: transaction);
                    },
                  ),
                  BlurDialogOption(
                    label: 'Excluir',
                    icon: Icons.delete,
                    iconColor: Theme.of(context).colorScheme.error,
                    textColor: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                    onTap: () {
                      CustomDeleteDialog.show(
                        context,
                        onPressed: () {
                          Navigator.pop(context);
                          controller.alterTransaction(transaction: transaction, isDelete: true);
                        },
                      );
                    },
                  ),
                ],
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                spacing: 10,
                children: [
                  CustomContainer(
                    backgroundColor: ColorUtil().formatColor(transaction.category.color),
                    iconColor: ColorUtil().darken(ColorUtil().formatColor(transaction.category.color), 0.3),
                    isLoading: controller.isDeleting[transaction],
                    iconData: transaction.type == "expense" ? Icons.arrow_downward : Icons.arrow_upward,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.description,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          transaction.category.name,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: transaction.type == 'income'
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Theme.of(context).colorScheme.errorContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          UtilBrasilFields.obterReal(transaction.amount),
                          style: TextStyle(
                            color: transaction.type == 'income'
                                ? Theme.of(context).colorScheme.onPrimaryContainer
                                : Theme.of(context).colorScheme.onErrorContainer,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
