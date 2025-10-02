import 'package:flutter/foundation.dart';
import '../../../../domain/entities/text_section_entity.dart';
import '../../../domain/usecases/load_legal_document.dart';

class TextSectionProvider with ChangeNotifier {
  final LoadLegalDocument loadLegalDocument;

  TextSectionProvider({required this.loadLegalDocument});

  final Map<String, List<TextSectionEntity>> _cache = {};
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<TextSectionEntity>? getSections(String key) => _cache[key];

  Future<void> preloadSections(String key, String filePath) async {
    if (_cache.containsKey(key)) return;

    _isLoading = true;
    notifyListeners();

    final sections = await loadLegalDocument(filePath);
    _cache[key] = sections;

    _isLoading = false;
    notifyListeners();
  }
}
