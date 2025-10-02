import 'package:in_app_review/in_app_review.dart';
import 'package:logger/logger.dart';

import '../../domain/repositories/preferences_repository.dart';

/// Service for show in_app_review
class EngagementRate {
  final Logger _logger;
  final InAppReview _reviewApi;
  final PreferencesRepository _prefs;

  EngagementRate({
    required PreferencesRepository prefs,
    Logger? logger,
    InAppReview? reviewApi,
  }) : _prefs = prefs,
       _logger = logger ?? Logger(),
       _reviewApi = reviewApi ?? InAppReview.instance;

  Future<void> registerLaunch() async {
    try {
      final updated = await _prefs.increaseLaunchCounter();
      _logger.i('[Review] Launch count updated: $updated');
    } catch (e, st) {
      _logger.e('[Review] Failed to register launch', error: e, stackTrace: st);
    }
  }

  Future<void> maybeShowReview() async {
    try {
      if (_prefs.isReviewAlreadyShown()) {
        _logger.i('[Review] Already shown → skip');
        return;
      }

      final count = _prefs.getLaunchCount();
      _logger.i('[Review] Current count: $count');

      if (_shouldPromptReview(count)) {
        await _promptSystemReview();
      }
    } catch (e, st) {
      _logger.e('[Review] Error in maybeShowReview', error: e, stackTrace: st);
    }
  }

  bool _shouldPromptReview(int count) {
    return count == 3;
  }

  Future<void> _promptSystemReview() async {
    try {
      final available = await _reviewApi.isAvailable();
      if (available) {
        _logger.i('[Review] Requesting system review');
        await _reviewApi.requestReview();
        await _prefs.setReviewShown(true);
        _logger.i('[Review] Marked as shown');
      } else {
        _logger.w('[Review] API not available');
      }
    } catch (e, st) {
      _logger.e('[Review] Prompt failed', error: e, stackTrace: st);
    }
  }
}
