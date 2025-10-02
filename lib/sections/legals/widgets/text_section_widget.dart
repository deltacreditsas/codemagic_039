import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../common/themes/app_spacing.dart';
import '../../../domain/entities/text_section_entity.dart';

class TextSectionWidget extends StatelessWidget {
  final List<TextSectionEntity> sections;

  const TextSectionWidget({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(context.spacing.size16),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: context.spacing.size12),
            MarkdownBody(
              data: section.body,
              styleSheet: MarkdownStyleSheet(
                p: Theme.of(context).textTheme.bodyMedium,
                strong: const TextStyle(fontWeight: FontWeight.bold),
                listBullet: const TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: context.spacing.size25),
          ],
        );
      },
    );
  }
}
