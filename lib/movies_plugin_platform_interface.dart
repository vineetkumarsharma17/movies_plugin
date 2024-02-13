import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'movies_plugin_method_channel.dart';

abstract class MoviesPluginPlatform extends PlatformInterface {
  /// Constructs a MoviesPluginPlatform.
  MoviesPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MoviesPluginPlatform _instance = MethodChannelMoviesPlugin();

  /// The default instance of [MoviesPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMoviesPlugin].
  static MoviesPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MoviesPluginPlatform] when
  /// they register themselves.
  static set instance(MoviesPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> searchMovies(String title) {
    throw UnimplementedError('searchMovies() has not been implemented.');
  }
}
