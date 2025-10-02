import '../../data/repositories_impl/legal_repository_impl.dart';
import '../entities/text_section_entity.dart';

class LoadLegalDocument {
  final LegalDocumentRepository repository;

  LoadLegalDocument(this.repository);

  Future<List<TextSectionEntity>> call(String filePath) {
    return repository.loadSections(filePath);
  }
}
