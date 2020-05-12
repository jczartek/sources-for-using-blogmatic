// Plik źródłowy: ./plugins/c-extension.h
#pragma once

#include <gtk/gtk.h>
#include <extensya.h>

G_BEGIN_DECLS

#define C_TYPE_EXTENSION (c_extension_get_type())

G_DECLARE_FINAL_TYPE (CExtension, c_extension, C, EXTENSION, GObject)

G_END_DECLS
