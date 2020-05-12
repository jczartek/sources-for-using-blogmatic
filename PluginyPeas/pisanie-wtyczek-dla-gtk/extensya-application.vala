// Plik źródłowy: extensya-application.vala
namespace Extensya {
  public class Application : Gtk.Application {
    public Peas.Engine engine { get; private set; }
    public Application() {
      Object(application_id: "org.github.jczartek.extensya", flags: ApplicationFlags.FLAGS_NONE);

      engine = Peas.Engine.get_default();
      configure_plugins();
    }

    protected override void activate() {
      var win = get_active_window();

      if (win == null) {
        win = new Window(this);
      }
      load_plugins();
      win.present();
    }

    protected override void shutdown() {
      unload_plugins();
      base.shutdown();
    }

    private void configure_plugins()
    {
      engine.enable_loader("python3");

      string dir = Environment.get_current_dir() + "/plugins";
      engine.add_search_path(dir, dir);

    }

    private void load_plugins() {
      foreach (var plugin in engine.get_plugin_list()) {
        if (!engine.try_load_plugin(plugin))
        {
          warning("Can't load the plugin %s", plugin.get_name());
        }
      }
    }

    private void unload_plugins() {
      foreach (var plugin in engine.get_plugin_list()) {
        if(!engine.try_unload_plugin(plugin)) 
        {
          warning("Can't unload the plugin %s", plugin.get_name());
        }
      }
    }
  }
}
