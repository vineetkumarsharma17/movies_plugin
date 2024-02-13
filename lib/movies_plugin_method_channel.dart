import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'movies_plugin_platform_interface.dart';

/// An implementation of [MoviesPluginPlatform] that uses method channels.
class MethodChannelMoviesPlugin extends MoviesPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('movies_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> searchMovies(String title) async {
    return await methodChannel.invokeMethod<String>('searchMovies', title);
  }
}
