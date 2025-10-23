import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piggai/component/category/category_bottom_sheet_to_transaction.dart';
import 'package:piggai/component/custom_choice_chip.dart';
import 'package:piggai/component/custom_text_form_field.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:piggai/controller/transaction_controller.dart';
import 'package:piggai/model/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionModalBottom {
  void show(BuildContext context, TransactionController controller, String type, {TransactionModel? transaction}) {
    String description = type == "income" ? "receita" : "despesa";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Observer(
            builder: (context) {
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
                          const SizedBox(height: 8),
                          const Text(
                            "Registre suas despesas e receitas para melhor análise",
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 20),

                          // Descrição
                          CustomTextFormField(
                            maxLength: 50,
                            hintText: "Descrição da $description",
                            controller: controller.tecDescriptionTransaction,
                            required: true,
                            autofocus: true,
                          ),
                          const SizedBox(height: 16),

                          // Valor
                          CustomTextFormField(
                            hintText: "Valor da $description",
                            controller: controller.tecAmountTransaction,
                            required: true,
                            suffixIcon: IconButton(
                              onPressed: () => controller.tecAmountTransaction.clear(),
                              icon: const Icon(Icons.close, size: 18),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CentavosInputFormatter(moeda: true)
                            ],
                            keyboardType: TextInputType.numberWithOptions(),
                          ),
                          const SizedBox(height: 12),

                          // Botões de valor rápido
                          _buildQuickAmounts(controller),
                          const SizedBox(height: 20),

                          // Linha: Categoria + Data
                          _buildCategoryAndDateRow(context, controller, type),
                          const SizedBox(height: 24),

                          // Botão de salvar
                          ElevatedButton(
                            onPressed: () async {
                              if(controller.formKey.currentState!.validate() && !controller.isInserting){
                                // await controller.saveTransaction(transaction: transaction);
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

  Widget _buildQuickAmounts(TransactionController controller) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final value in [0.5, 1.0, 5.0, 10.0, 20.0, 50.0, 100.0])
          CustomChoiceChip(
            text: "+ ${UtilBrasilFields.obterReal(value)}",
            selected: false,
            onSelected: (p0) {
              controller.addAmount(value);
            },
          ),
      ],
    );
  }

  Widget _buildCategoryAndDateRow(BuildContext context, TransactionController controller, String type) {
    return Row(
      children: [
        // Categoria - 70% da largura
        Expanded(
          flex: 7,
          child: _buildCategorySelector(context, controller, type),
        ),
        const SizedBox(width: 12),

        // Data - 30% da largura
        Expanded(
          flex: 3,
          child: _buildDateSelector(context, controller),
        ),
      ],
    );
  }

  Widget _buildCategorySelector(BuildContext context, TransactionController controller, String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Categoria",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => CategoryBottomSheetToTransaction().show(context, controller, type),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Observer(builder: (context) {
                    final category = null;
                    return Expanded(
                      child: Text(
                        category?.name ?? "Selecionar",
                        style: TextStyle(
                          color: category == null ? Colors.grey[600] : Colors.black87,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }),
                  const Icon(Icons.arrow_drop_down, size: 20, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector(BuildContext context, TransactionController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Data",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => _showDatePicker(context, controller),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Observer(builder: (context) {
                    final date = DateTime.now();
                    return Expanded(
                      child: Text(
                        DateFormat('dd/MM').format(date),
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }),
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context, TransactionController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: controller.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4B4EA0), // Sua cor primária
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // controller.setSelectedDate(picked);
    }
  }
}
