#ifndef FLUTTER_PLUGIN_MOVIES_PLUGIN_H_
#define FLUTTER_PLUGIN_MOVIES_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace movies_plugin {

class MoviesPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  MoviesPlugin();

  virtual ~MoviesPlugin();

  // Disallow copy and assign.
  MoviesPlugin(const MoviesPlugin&) = delete;
  MoviesPlugin& operator=(const MoviesPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace movies_plugin

#endif  // FLUTTER_PLUGIN_MOVIES_PLUGIN_H_
