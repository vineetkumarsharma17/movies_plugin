//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <movies_plugin/movies_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) movies_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MoviesPlugin");
  movies_plugin_register_with_registrar(movies_plugin_registrar);
}
