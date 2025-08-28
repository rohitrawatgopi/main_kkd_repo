import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyCacheManager extends CacheManager {
  static const key = "customCache";

  static final instance = MyCacheManager._();

  MyCacheManager._()
    : super(
        Config(
          maxNrOfCacheObjects: 300,
          key,

          stalePeriod: const Duration(days: 7),

          repo: JsonCacheInfoRepository(databaseName: key),
          fileService: HttpFileService(),
        ),
      );
}
