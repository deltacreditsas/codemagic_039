import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/survey_notifier.dart';
import '../widgets/step1_widget.dart';
import '../widgets/step2_widget.dart';
import '../widgets/step3_widget.dart';
import '../widgets/step4_widget.dart';
import '../widgets/step5_widget.dart';


class SurveyFlow extends StatelessWidget {
  const SurveyFlow({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SurveyNotifier>();

    switch (notifier.step) {
      case SurveyStep.step1:
        return const Step1Widget();
      case SurveyStep.step2:
        return const Step2Widget();
      case SurveyStep.step3:
        return const Step3Widget();
      case SurveyStep.step4:
        return const Step4Widget();
      case SurveyStep.step5:
        return const Step5Widget();
    }
  }
}
