#include "include/movies_plugin/movies_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "movies_plugin.h"

void MoviesPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  movies_plugin::MoviesPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
