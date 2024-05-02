import 'package:usdol/app/core.dart';

class SyncResponse {
  final SyncStatus status;
  final bool isAutoTrigger;

  SyncResponse({
    required this.isAutoTrigger,
    required this.status,
  });
}
