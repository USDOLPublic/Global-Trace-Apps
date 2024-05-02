import 'package:usdol/app/core.dart';

class HistoryRepo extends ActiveRepo<String, HistoryModel> {
  @override
  String get boxName => ModelTypeDefine.historyBox;

  Future<void> putAndUpdate(List<HistoryModel> histories) async {
    Map<String, HistoryModel> mapData = <String, HistoryModel>{};
    for (var e in histories) {
      mapData[e.id ?? ""] = e;
    }
    if (mapData.isNotEmpty) {
      await putAllAndUpdateExistingMapped(
        mapData,
        (String key, HistoryModel? mutateMe, HistoryModel newValue) {
          return newValue;
        },
      );
    }
  }

  List<HistoryModel> getPageItem(HistoryReq historyReq) {
    List<HistoryModel> histories = getAllValues().values.toList();

    if (histories.isNotEmpty) {
      histories = histories.where(
        (element) {
          //LogUtil.d("trans: ${element.transactedAt} from: ${historyReq.from} to: ${historyReq.to}");
          return (element.createdAt ?? 0) > historyReq.from && (element.createdAt ?? 0) < historyReq.to;
        },
      ).toList();
      histories.sort((a, b) => (b.getTradeDate() ?? DateTime.now()).compareTo(a.getTradeDate() ?? DateTime.now()));
    }

    int start = (historyReq.page - 1) * historyReq.perPage;
    int end = historyReq.page * historyReq.perPage;
    if (end > histories.length) {
      end = histories.length;
    }
    if (start > histories.length) {
      return <HistoryModel>[];
    }
    return histories.getRange(start, end).toList();
  }

  List<HistoryModel> getPageItemByHis(HistoryReq historyReq, List<HistoryModel> histories) {
    int start = (historyReq.page - 1) * historyReq.perPage;
    int end = historyReq.page * historyReq.perPage;
    if (end > histories.length) {
      end = histories.length;
    }
    if (start > histories.length) {
      return <HistoryModel>[];
    }
    return histories.getRange(start, end).toList();
  }

  List<HistoryModel> getAllItemByDateRange(HistoryReq historyReq) {
    List<HistoryModel> histories = getAllValues().values.toList();

    if (histories.isNotEmpty) {
      histories = histories.where(
        (element) {
          //LogUtil.d("trans: ${element.transactedAt} from: ${historyReq.from} to: ${historyReq.to}");
          return (element.recordedAt ?? 0) > historyReq.from && (element.recordedAt ?? 0) < historyReq.to;
        },
      ).toList();
      histories.sort((a, b) => (b.getTradeDate() ?? DateTime.now()).compareTo(a.getTradeDate() ?? DateTime.now()));
    }
    return histories;
  }
}
