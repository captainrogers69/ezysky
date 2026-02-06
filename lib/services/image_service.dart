import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final fastCacheImageServiceProvider = Provider<ImageCacheService>((ref) {
  return ImageCacheService.instance;
});

class ImageCacheService {
  ImageCacheService._internal();

  static final ImageCacheService _instance = ImageCacheService._internal();

  static ImageCacheService get instance => _instance;

  late final CacheManager _cacheManager;

  bool _isInitialized = false;

  /// Call once (main())
  Future<void> init() async {
    if (_isInitialized) return;

    _cacheManager = CacheManager(
      Config(
        'appImageCache',
        stalePeriod: const Duration(days: 5),
        maxNrOfCacheObjects: 500,
      ),
    );

    _isInitialized = true;
  }

  CacheManager get cacheManager {
    if (!_isInitialized) {
      throw StateError(
        'ImageCacheService not initialized. Call init() in main().',
      );
    }
    return _cacheManager;
  }
}
