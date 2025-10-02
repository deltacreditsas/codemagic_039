import '../entities/text_section_entity.dart';

abstract class LegalDocumentRepositoty {
  Future<List<TextSectionEntity>> loadSections(String filePath);
}
