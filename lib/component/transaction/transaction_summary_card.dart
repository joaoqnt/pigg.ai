import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class TransactionSummaryCard extends StatelessWidget {
  final double income;
  final double expense;

  const TransactionSummaryCard({
    super.key,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final balance = income - expense;

    final incomeColor = colorScheme.tertiary;
    final expenseColor = colorScheme.error;
    final positiveBalanceColor = colorScheme.secondary;

    return Card(
      color: colorScheme.tertiaryContainer,
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              context: context,
              label: "Receitas",
              value: income,
              valueColor: incomeColor,
              icon: Icons.attach_money_sharp,
            ),
            _buildItem(
              context: context,
              label: "Saldo",
              value: balance,
              valueColor: balance >= 0 ? positiveBalanceColor : expenseColor,
              isBold: true,
              icon: Icons.savings_outlined,
            ),
            _buildItem(
              context: context,
              label: "Despesas",
              value: expense,
              valueColor: expenseColor,
              icon: Icons.money_off,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildItem({
    required BuildContext context,
    required String label,
    required double value,
    required Color valueColor,
    required IconData icon,
    bool isBold = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onTertiaryContainer,
                ),
              ),
              Text(
                UtilBrasilFields.obterReal(value),
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onTertiaryContainer,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}