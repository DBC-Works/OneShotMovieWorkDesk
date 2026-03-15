/**
 * HTML color value
 */
public final class HtmlColorValue extends NamedColorValue {
  public static final ColorValue DARK_RED = new HtmlColorValue("dark red", 139, 0, 0);
  public static final ColorValue DODGER_BLUE = new HtmlColorValue("dodger blue", 30, 144, 255);
  public static final ColorValue GHOST_WHITE = new HtmlColorValue("ghost white", 248, 248, 255);
  public static final ColorValue MAROON = new HtmlColorValue("maroon", 128, 0, 0);
  public static final ColorValue MIDNIGHT_BLUE = new HtmlColorValue("midnight blue", 25, 25, 112);
  public static final ColorValue CRIMSON = new HtmlColorValue("crimson", 220, 20, 60);

  /**
   * Constructor
   * @param n Name
   * @param r Red([0,255])
   * @param g Green([0,255])
   * @param b Blue([0,255])
   */
  private HtmlColorValue(String n, int r, int g, int b) {
    super(n, r, g, b);
  }
}
