import 'movies_plugin_platform_interface.dart';

class MoviesPlugin {
  Future<String?> getPlatformVersion() {
    return MoviesPluginPlatform.instance.getPlatformVersion();
  }

  Future<String?> searchMovies(String title) {
    return MoviesPluginPlatform.instance.searchMovies(title);
  }
}
