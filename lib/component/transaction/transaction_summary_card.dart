import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:piggai/util/responsive.dart';

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
    final cs = Theme.of(context).colorScheme;
    final balance = income - expense;

    return Card(
      color: cs.surfaceContainerLow,
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              context,
              label: "Receitas",
              value: income,
              icon: Icons.arrow_upward_rounded,
              valueColor: cs.primary,
            ),
            _buildItem(
              context,
              label: "Saldo",
              value: balance,
              icon: Icons.account_balance_wallet_rounded,
              valueColor: balance >= 0 ? cs.secondary : cs.error,
              isBold: true,
            ),
            _buildItem(
              context,
              label: "Despesas",
              value: expense,
              icon: Icons.arrow_downward_rounded,
              valueColor: cs.error,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, {
        required String label,
        required double value,
        required IconData icon,
        required Color valueColor,
        bool isBold = false,
      }) {
    final cs = Theme.of(context).colorScheme;

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!Responsive.isMobile(context)) ...[
            Icon(icon, size: 32, color: valueColor),
            const SizedBox(width: 8),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurfaceVariant.withOpacity(0.9),
                  )),
              Text(
                UtilBrasilFields.obterReal(value),
                style: TextStyle(
                  fontSize: 15,
                  color: valueColor,
                  fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
