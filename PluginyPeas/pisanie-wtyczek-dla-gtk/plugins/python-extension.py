# Plik źródłowy: ./plugins/pyhon-extension.c
import gi

gi.require_version('Gtk', '3.0')
gi.require_version('Peas', '1.0')
gi.require_version('Extensya', '1.0')

from gi.repository import Peas
from gi.repository import GObject
from gi.repository import Gtk
from gi.repository import Extensya

class PythonExtension(GObject.Object, Extensya.Extension):
    window = GObject.Property(type=Extensya.Window)
    button = GObject.Property(type=Gtk.Button)

    def do_activate(self):
        self.button = Gtk.Button(label="Python Extension Btn")
        self.button.connect("clicked", lambda _ : print("Python Extension: Hello World!"))
        self.window.add_button(self.button)
        self.button.show()

    def do_deactivate(self):
        self.window.remove_button(self.button);
