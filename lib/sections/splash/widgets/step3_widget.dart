import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/custom_buttom_widget.dart';
import '../providers/survey_notifier.dart';
import 'rating_stars.dart';
import 'survey_container_widget.dart';

class Step3Widget extends StatefulWidget {
  const Step3Widget({super.key});

  @override
  State<Step3Widget> createState() => _Step3WidgetState();
}

class _Step3WidgetState extends State<Step3Widget> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SurveyNotifier>();

    bool isValid = _controller.text.trim().length >= 3;

    return SurveyContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'splash.page3.title'.tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 12),

          Text('splash.page3.subtitle'.tr(), style: TextStyle(fontSize: 16)),
          const SizedBox(height: 20),

          RatingStars(rating: notifier.rating),
          const SizedBox(height: 20),

          TextField(
            controller: _controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'splash.page3.hintText'.tr(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              errorText: _errorText,
            ),
            onChanged: (value) {
              setState(() {
                _errorText = value.trim().length < 3
                    ? 'splash.page3.validation_text'.tr()
                    : null;
              });
            },
          ),
          const SizedBox(height: 20),

          CustomGradientButton(
            action: isValid
                ? () {
                    notifier.feedback = _controller.text.trim();
                    notifier.submitFeedback();
                  }
                : null,
            label: 'splash.button_send'.tr(),
            enabled: isValid,
          ),
        ],
      ),
    );
  }
}
