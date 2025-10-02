import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

import '../../data/repositories_impl/legal_repository_impl.dart';
import '../../domain/entities/text_section_entity.dart';

class TextSectionRepository implements LegalDocumentRepository {
  @override
  Future<List<TextSectionEntity>> loadSections(String filePath) async {
    final yamlString = await rootBundle.loadString(filePath);
    final yamlMap = loadYaml(yamlString) as YamlMap;
    final list = (yamlMap['sections'] as YamlList)
        .map((e) => TextSectionEntity(
      title: e['title'] ?? '',
      body: e['body'] ?? '',
    ))
        .toList();

    return List<TextSectionEntity>.from(list);
  }
}
