import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usdol/app/core.dart';

class LogItemWidget extends StatelessWidget {
  const LogItemWidget({
    super.key,
    required this.history,
    this.onAttachmentTap,
  });
  final HistoryModel history;
  final void Function(HistoryModel)? onAttachmentTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(8),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatus(context),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTradeAt(context),
                  const Spacer(),
                  _buildTradeIcon(context),
                  const SizedBox(width: 8),
                  _buildTradeName(context),
                  if (history.getCredentialFiles().isNotEmpty) ...[
                    InkWell(
                      onTap: () => onAttachmentTap?.call(history),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(AssetsConst.svgAttachFile),
                      ),
                    )
                  ],
                ],
              ),
            ],
          ),
          children: [
            LogItemDetailsWidget(history: history),
            if (_isEnableDisplayErrorCause())
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: "${S.of(context).failedBy} ",
                    children: [
                      TextSpan(
                        text: history.note ?? 'N/A',
                        style: const TextStyle(color: AppColors.red),
                      ),
                    ],
                    style: const TextStyle(color: AppColors.grey600),
                  ),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTradeIcon(BuildContext context) {
    switch (history.type) {
      case TransactionType.sale:
        return const Icon(
          Icons.sell_outlined,
          color: AppColors.grey600,
        );
      case TransactionType.purchase:
        return const Icon(
          Icons.shopping_cart_outlined,
          color: AppColors.grey600,
        );
      case TransactionType.transport:
        return const Icon(
          Icons.local_shipping_outlined,
          color: AppColors.grey600,
        );
      case TransactionType.transformation:
        return SvgPicture.asset(
          AssetsConst.icScanCode,
          width: 20,
          height: 20,
        );
      case TransactionType.recordByProduct:
        return const Icon(
          Icons.description_outlined,
          color: AppColors.grey600,
        );
      default:
        return const Icon(
          Icons.track_changes,
          color: AppColors.red,
        );
    }
  }

  bool _isEnableDisplayErrorCause() {
    return history.status == HistoryStatus.failed.toLowerCase() &&
        BuildConfig().isDebug;
  }

  Widget _buildStatus(BuildContext context) {
    Color statusColor = AppColors.green;
    String statusValue = HistoryStatus.complete;
    if (history.status == HistoryStatus.failed.toLowerCase()) {
      statusColor = AppColors.red;
      statusValue = HistoryStatus.failed;
    } else if (history.status == HistoryStatus.pending.toLowerCase()) {
      statusColor = AppColors.orange700;
      statusValue = HistoryStatus.pending;
    }

    String statusStr = HistoryStatus.getStatusString(context, statusValue);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: statusColor,
          ),
        ),
        Text(
          statusStr,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 10,
            color: statusColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTradeName(BuildContext context) {
    String tradeName = '';
    switch (history.type) {
      case TransactionType.sale:
        tradeName = S.of(context).sale;
        break;
      case TransactionType.purchase:
        tradeName = S.of(context).purchase;
        break;
      case TransactionType.transport:
        tradeName = S.of(context).transport;
        break;
      case TransactionType.transformation:
        tradeName = S.of(context).productId;
        break;
      case TransactionType.recordByProduct:
        tradeName = S.of(context).byProduct;
        break;
    }
    return Text(
      tradeName,
      style: const TextStyle(
        color: AppColors.grey300,
        fontWeight: FontWeight.w400,
        fontSize: 13,
      ),
    );
  }

  Widget _buildTradeAt(BuildContext context) {
    return Text(
      DateUtil.parseFromDateTime(
        history.getTradeDate(),
        "d MMM, yyyy",
      ),
      style: const TextStyle(
        color: AppColors.grey600,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }
}
