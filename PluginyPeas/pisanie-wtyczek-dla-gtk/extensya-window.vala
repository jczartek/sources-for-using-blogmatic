// Plik źródłowy: extensya-window.vala
namespace Extensya {
  public class Window : Gtk.ApplicationWindow {
    private Gtk.Box box_buttons;
    private Peas.ExtensionSet extensions { get; set; }

    public Window(Gtk.Application app) {
      Object(application: app);

      default_width = 600;
      default_height = 400;
      window_position = CENTER;

      var hb = new Gtk.HeaderBar();
      hb.show_close_button = true;
      hb.title = "Pluginy";

      var switcher = new Gtk.Switch();
      switcher.active = true;

      var label = new Gtk.Label("Pluginy: ");

      var box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 5);
      box.add(label);
      box.add(switcher);

      hb.pack_start(box);   
      set_titlebar(hb);

      box_buttons = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
      add(box_buttons);
      show_all();

      var btn = new Gtk.Button.with_label("Przycisk Aplikacji");
      btn.clicked.connect(() => { print("Application: Hello World!\n"); });
      add_button(btn);

      extensions = new Peas.ExtensionSet((app as Extensya.Application).engine, typeof (Extensya.Extension), "window", this);
      extensions.extension_added.connect((info, extension) => {
        (extension as Extensya.Extension).activate();
        });
      extensions.extension_removed.connect((info, extension) => {
        (extension as Extensya.Extension).deactivate();
      });

      switcher.notify["active"].connect(() => {
        var engine = Peas.Engine.get_default();
        if (switcher.get_active())
        {
          foreach (var plugin in engine.get_plugin_list()) {
            if (!engine.try_load_plugin(plugin))
            {
              warning("Can't load the plugin %s", plugin.get_name());
            }
          }
        } 
        else
        {
          foreach (var plugin in engine.get_plugin_list()) {
            if(!engine.try_unload_plugin(plugin)) {
              warning("Can't unload the plugin %s", plugin.get_name());
            }
          }
        }
      });
    }

    public void add_button(Gtk.Button btn) requires(btn is Gtk.Button) {
      btn.show();
      box_buttons.add(btn);
    }

    public void remove_button(Gtk.Button btn) requires(btn is Gtk.Button) {
      box_buttons.remove(btn);
    }
  }
}
