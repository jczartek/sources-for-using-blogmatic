// Plik źródłowy: ./plugins/vala-extension.vala
class ValaExtension : Object, Extensya.Extension {

    public Extensya.Window window { get; set; }
    private Gtk.Button button;

    void activate() {
        button = new Gtk.Button.with_label("Vala Extension Btn");

        /* Change label when clicked */
        button.clicked.connect(() => {
            print("Vala Extension: Hello World!\n");
        });

        /* The magic, it's happening! */
        window.add_button(button);
        button.show();
    }

    void deactivate() {
        window.remove_button(button);
    }
}

/* Register extension types */
[ModuleInit]
public void peas_register_types(TypeModule module) {
    var objmodule = module as Peas.ObjectModule;

    objmodule.register_extension_type(typeof (Extensya.Extension), typeof (ValaExtension));
}
