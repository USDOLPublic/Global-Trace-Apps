import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class LogItemDetailsWidget extends StatelessWidget {
  const LogItemDetailsWidget({
    super.key,
    required this.history,
    this.onTap,
  });
  final HistoryModel history;
  final void Function(HistoryModel)? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Theme.of(context).cardColor,
                  padding: const EdgeInsets.only(right: 4),
                  child: _buildTradeInfo(context),
                ),
              ),
              const SizedBox(width: 1),
              Flexible(
                flex: 2,
                child: Container(
                  color: Theme.of(context).cardColor,
                  padding: const EdgeInsets.only(left: 4),
                  child: Center(
                    child: Text(
                      history.getTradeName(),
                      style: const TextStyle(
                        color: AppColors.grey600,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTradeInfo(BuildContext context) {
    switch (history.type) {
      case TransactionType.purchase:
        return LogPurchaseDetailsWidget(history: history);
      case TransactionType.sale:
        return LogSaleDetailsWidget(history: history);
      case TransactionType.transport:
        return LogTransportDetailsWidget(history: history);
      case TransactionType.transformation:
        return LogTransformDetailsWidget(history: history);
      case TransactionType.recordByProduct:
        return LogRecordProductDetailsWidget(history: history);
    }
    return const SizedBox.shrink();
  }
}
