import 'package:hive/hive.dart';

import 'disposable.dart';

/// the CacheService should implment this interface in a production app
abstract class CacheServiceInterface with DisposableMixin {
  /// Register all type adapters needed by hive
  void registerTypeAdapters();

  /// Initialize repositories, DO NOT CALL THIS DIRECTLY, INSTEAD CALL [init]
  Future<void> initRepos();

  Future<void> init() async {
    registerTypeAdapters();
    await initRepos();
  }

  @override
  Future<void> dispose() async {}

  Future<void> openBox<T>(String box) async {
    if (!Hive.isBoxOpen(box)) {
      await Hive.openBox<T>(box);
    }
  }

  void registerTypeAdapter<T>(int type, TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(type)) {
      Hive.registerAdapter(
        adapter,
        override: true,
      );
    }
  }
}
