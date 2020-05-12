// Plik źródłowy: ./plugins/c-extension.c
#include "c-extension.h"

struct _CExtension
{
  GObject parent_instance;
  ExtensyaWindow *window;
  GtkButton *btn;
};

static void extensya_iface_init (ExtensyaExtensionIface *iface);

G_DEFINE_TYPE_WITH_CODE (CExtension, c_extension, G_TYPE_OBJECT,
                         G_IMPLEMENT_INTERFACE (EXTENSYA_TYPE_EXTENSION, extensya_iface_init))

enum {
  PROP_0,
  PROP_WINDOW,
  N_PROPS
};

static void
c_extension_get_property (GObject    *object,
                          guint       prop_id,
                          GValue     *value,
                          GParamSpec *pspec)
{
  CExtension *self = C_EXTENSION (object);

  switch (prop_id)
    {
    case PROP_WINDOW:
      g_value_set_object (value, self->window);
      break;
    default:
      G_OBJECT_WARN_INVALID_PROPERTY_ID (object, prop_id, pspec);
    }
}

static void
c_extension_set_property (GObject      *object,
                          guint         prop_id,
                          const GValue *value,
                          GParamSpec   *pspec)
{
  CExtension *self = C_EXTENSION (object);

  switch (prop_id)
    {
    case PROP_WINDOW:
      self->window = (ExtensyaWindow *) g_value_get_object (value);
      break;
    default:
      G_OBJECT_WARN_INVALID_PROPERTY_ID (object, prop_id, pspec);
    }
}

static void
c_extension_class_init (CExtensionClass *klass)
{
  GObjectClass *object_class = G_OBJECT_CLASS (klass);

  object_class->get_property = c_extension_get_property;
  object_class->set_property = c_extension_set_property;
  g_object_class_override_property (object_class, PROP_WINDOW, "window");
}

static void
c_extension_init (CExtension *self)
{
}

void
clicked_cb (GtkButton *button,
            gpointer   user_data)
{
  g_print("C Extension: Hello World!\n");
}

static void activate (ExtensyaExtension* base)
{
  CExtension *self = (CExtension *)base;

  self->btn = (GtkButton *) gtk_button_new_with_label("C Extension Btn");
  g_signal_connect (self->btn, "clicked",
                    G_CALLBACK (clicked_cb), NULL);
  extensya_window_add_button (self->window, self->btn);
}

static void deactivate (ExtensyaExtension* base)
{
  CExtension *self = (CExtension *)base;
  extensya_window_remove_button (self->window, self->btn);
}

static void
extensya_iface_init (ExtensyaExtensionIface *iface)
{
  iface->activate = activate;
  iface->deactivate = deactivate;
}

#include <libpeas/peas.h>

G_MODULE_EXPORT void
peas_register_types (PeasObjectModule *module)
{
  peas_object_module_register_extension_type (module, EXTENSYA_TYPE_EXTENSION, C_TYPE_EXTENSION);
}
