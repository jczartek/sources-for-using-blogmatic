// Plik źródłowy: extensya-extension.vala
namespace Extensya {
  public interface Extension : Object {

    public abstract Window window { get; set; }

    public abstract void activate();

    public abstract void deactivate();
  }
}
