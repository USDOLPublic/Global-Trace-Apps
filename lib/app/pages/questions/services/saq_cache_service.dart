import 'dart:convert';
import 'package:usdol/app/core.dart';

class SAQCacheService {
  SaqResp? getSAQLatestInStorage(String userId, String language) {
    try {
      String dataStr = Prefs.getString(Defines.saqLatestDataKey + userId);
      Map<String, dynamic> dataJson = jsonDecode(dataStr) as Map<String, dynamic>;
      SaqResp saqData = SaqResp.fromJson(dataJson, language: language);
      return saqData;
    } catch (e) {
      LogUtil.e("getSAQLatestInStorage: " + e.toString());
      return null;
    }
  }

  Future<bool> saveSAQLatestData(String userId, Map<String, dynamic> saqData) async {
    String dataStr = jsonEncode(saqData);
    return Prefs.saveString(Defines.saqLatestDataKey + userId, dataStr);
  }

  List<SaqAnswerItem>? getSAQAnswerInStorage(String userId) {
    try {
      String dataStr = Prefs.getString(Defines.saqAnswerDataKey + userId);
      List dataJson = jsonDecode(dataStr) as List;
      //Parse json (List Type)
      List<SaqAnswerItem> saqList = dataJson.map((dynamic e) => SaqAnswerItem.fromJson(e as Map<String, dynamic>)).toList();
      return saqList;
    } catch (e) {
      LogUtil.e("getSAQAnswerInStorage: " + e.toString());
      return null;
    }
  }

  Future<bool> saveSAQAnswerData(String userId, List<dynamic> saqData) async {
    String dataStr = jsonEncode(saqData);
    return Prefs.saveString(Defines.saqAnswerDataKey + userId, dataStr);
  }
}
