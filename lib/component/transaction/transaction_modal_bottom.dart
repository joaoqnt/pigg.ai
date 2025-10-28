import 'package:brasil_fields/brasil_fields.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piggai/component/category/category_dropdown.dart';
import 'package:piggai/component/custom_choice_chip.dart';
import 'package:piggai/component/custom_date_picker.dart';
import 'package:piggai/component/custom_text_form_field.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:piggai/controller/transaction_controller.dart';
import 'package:piggai/model/transaction_model.dart';

import '../../util/formatter/real_input_formatter.dart';

class TransactionModalBottom {
  void show(BuildContext context, TransactionController controller, String type, {TransactionModel? transaction,TransactionModel? transactionClone}) {
    String description = type == "income" ? "receita" : "despesa";
    controller.setTransaction(
        transactionClone??transaction,
        type,
        isClone: transactionClone != null
    );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Observer(
            builder: (context) {
              final bigSpacing = SizedBox(height: 10);
              return Form(
                key: controller.formKey,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 30,
                  ),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${transaction == null ? "Criar" : "Editar"} $description",
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close, size: 18),
                              ),
                            ],
                          ),
                          const Text(
                            "Registre suas despesas e receitas para melhor análise",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 8),
                          // Descrição
                          CustomTextFormField(
                            maxLength: 50,
                            hintText: "Restaurante",
                            labelText: "Descrição da $description",
                            controller: controller.tecDescriptionTransaction,
                            required: true,
                            autofocus: true,
                            prefixIcon: Icon(Icons.description),
                          ),
                          bigSpacing,
                          // Valor
                          CustomTextFormField(
                            hintText: "${UtilBrasilFields.obterReal(50)}",
                            labelText: "Valor da $description",
                            controller: controller.tecAmountTransaction,
                            required: true,
                            suffixIcon: IconButton(
                              onPressed: () => controller.tecAmountTransaction.clear(),
                              icon: const Icon(Icons.close, size: 18),
                            ),
                            inputFormatters: [
                              BrazilianMoneyInputFormatter()
                            ],
                            keyboardType: TextInputType.numberWithOptions(),
                            prefixIcon: Icon(Icons.attach_money),
                          ),
                          SizedBox(height: 8),
                          // Botões de valor rápido
                          _buildQuickAmounts(controller),
                          SizedBox(height: 8),
                          _buildQuickAmounts(controller,add: false),

                          bigSpacing,
                          CategoryDropdown(
                            categories: controller.categories.where((element) => element.type == type,).toList(),
                            onChanged: (p0) => controller.setCategory(p0),
                            categorySelected: controller.categorySelected,
                          ),
                          bigSpacing,
                          CustomDatePicker(controller: controller.tecDateTransaction),
                          bigSpacing,
                          // Botão de salvar
                          Row(
                            children: [
                              Expanded(
                                child: FilledButton(
                                  onPressed: () async {
                                    if(controller.formKey.currentState!.validate() && !controller.isInserting){
                                      await controller.alterTransaction(transaction: transaction);
                                    }
                                  },
                                  child: controller.isInserting
                                      ? const Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(color: Colors.white),
                                    ),
                                  )
                                      : Text("${transaction == null ? "Criar" : "Editar"} $description"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        );
      },
    );
  }

  Widget _buildQuickAmounts(TransactionController controller, {bool add = true}) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final value in [0.5, 1.0, 5.0, 10.0, 20.0, 50.0, 100.0, 500.0])
          CustomChoiceChip(
            text: "${add == true ? "+" : "-"} ${UtilBrasilFields.obterReal(value)}",
            selected: false,
            onSelected: (p0) {
              if(add) {
                controller.addAmount(value);
              } else {
                controller.removeAmount(value);
              }
            },
          ),
      ],
    );
  }
}
