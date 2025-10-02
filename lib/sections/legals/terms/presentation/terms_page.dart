import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../common/themes/app_palette.dart';
import '../../../../common/widgets/local_appbar.dart';
import '../../../home/presentation/home_page.dart';
import '../../providers/text_section_provider.dart';
import '../../widgets/text_section_widget.dart';

class TermsPage extends StatelessWidget {
  static const String id = 'id_terms';

  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextSectionProvider>();
    final sections = provider.getSections('terms');

    if (provider.isLoading && sections == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: context.palette.lavender),
        ),
      );
    }

    return Scaffold(
      appBar: simpleCustomAppBar(
        context: context,
        title: 'terms.title'.tr(),
        onBack: () => context.pushReplacement('/${HomePage.id}'),
      ),
      body: TextSectionWidget(sections: sections ?? []),
    );
  }
}
