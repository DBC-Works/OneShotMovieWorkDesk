/**
 * Named color value
 */
public abstract class NamedColorValue extends ColorValue {
  /**
   * Name
   */
  private final String name;

  /**
   * Constructor
   * @param n Name
   * @param r Red([0,255])
   * @param g Green([0,255])
   * @param b Blue([0,255])
   */
  protected NamedColorValue(String n, int r, int g, int b) {
    super(r, g, b);
    name = n;
  }

  /**
   * Get name
   * @return name
   */
  public final String getName() {
    return name;
  }

  @Override
  public final String toString() {
    return String.format("%s(%d, %d, %d)", name, getRed(), getGreen(), getBlue());
  }
}
