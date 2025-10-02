import '../../domain/entities/text_section_entity.dart';

abstract class LegalDocumentRepository {
  Future<List<TextSectionEntity>> loadSections(String filePath);
}
