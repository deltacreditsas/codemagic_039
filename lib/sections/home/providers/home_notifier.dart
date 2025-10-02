import 'package:flutter/material.dart';

class HomeUiState extends ChangeNotifier {
  bool _showLegalButton = false;
  bool get showLegalButton => _showLegalButton;

  final List<String> steps = [
    'main.benefits1',
    'main.benefits2',
    'main.benefits3',
  ];

  void toggleLegal() {
    _showLegalButton = !_showLegalButton;
    notifyListeners();
  }

  void closeLegal() {
    _showLegalButton = false;
    notifyListeners();
  }
}
