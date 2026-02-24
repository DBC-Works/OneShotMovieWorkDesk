/**
 * HTML color name definitions
 */
public final class HtmlColorName extends ColorName {
  public static final HtmlColorName DARK_RED = new HtmlColorName("dark red", 139, 0, 0);
  public static final HtmlColorName DODGER_BLUE = new HtmlColorName("dodger blue", 30, 144, 255);
  public static final HtmlColorName GHOST_WHITE = new HtmlColorName("ghost white", 248, 248, 255);
  public static final HtmlColorName MAROON = new HtmlColorName("maroon", 128, 0, 0);
  public static final HtmlColorName MIDNIGHT_BLUE = new HtmlColorName("midnight blue", 25, 25, 112);
  public static final HtmlColorName CRIMSON = new HtmlColorName("crimson", 220, 20, 60);

  /**
   * Constructor
   * @param n Name
   * @param r Red([0,255])
   * @param g Green([0,255])
   * @param b Blue([0,255])
   */
  private HtmlColorName(String n, int r, int g, int b) {
    super(n, r, g, b);
  }
}
