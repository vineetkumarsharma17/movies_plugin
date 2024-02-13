import 'package:flutter_test/flutter_test.dart';
import 'package:movies_plugin/movies_plugin.dart';
import 'package:movies_plugin/movies_plugin_platform_interface.dart';
import 'package:movies_plugin/movies_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMoviesPluginPlatform
    with MockPlatformInterfaceMixin
    implements MoviesPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MoviesPluginPlatform initialPlatform = MoviesPluginPlatform.instance;

  test('$MethodChannelMoviesPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMoviesPlugin>());
  });

  test('getPlatformVersion', () async {
    MoviesPlugin moviesPlugin = MoviesPlugin();
    MockMoviesPluginPlatform fakePlatform = MockMoviesPluginPlatform();
    MoviesPluginPlatform.instance = fakePlatform;

    expect(await moviesPlugin.getPlatformVersion(), '42');
  });
}
