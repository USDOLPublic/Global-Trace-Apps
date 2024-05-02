import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class InCompleteWidget extends StatelessWidget {
  const InCompleteWidget({
    super.key,
    required this.incompleteList,
  });
  final List<SaqSubmitResp> incompleteList;

  Map<String, List<String>> _processIncompleteData() {
    Map<String, List<String>> incompleteGroups = <String, List<String>>{};
    for (var incomplete in incompleteList) {
      String groupTitle = incomplete.title?.value ?? '';
      List<String> questionsIncomplete = incompleteGroups[groupTitle] ?? [];
      if (incomplete.questionOrder != null) {
        questionsIncomplete.add(incomplete.questionOrder.toString());
        incompleteGroups[groupTitle] = questionsIncomplete;
      }
    }
    return incompleteGroups;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleGroupStyle = const TextStyle(
      color: AppColors.green800,
      fontWeight: FontWeight.w600,
    );
    TextStyle infoStyle = const TextStyle(
      color: AppColors.grey600,
      fontWeight: FontWeight.w500,
    );

    List<Widget> groupInfos = <Widget>[];
    Map<String, List<String>> incompleteGroups = _processIncompleteData();
    incompleteGroups.forEach((key, value) {
      String questionsIncompleteStr = value.join(', ');
      groupInfos.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(key, style: titleGroupStyle),
          const SizedBox(height: 8),
          Text("${S.of(context).question} $questionsIncompleteStr", style: infoStyle),
        ]),
      ));
    });
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.warning_amber_rounded,
              color: Theme.of(context).colorScheme.error,
              size: 64,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              S.of(context).theFllowingQuestionIncomplete,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.grey600,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: groupInfos,
          ),
        ],
      ),
    );
  }
}
