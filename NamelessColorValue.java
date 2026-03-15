/**
 * Nameless color value
 */
public final class NamelessColorValue extends ColorValue {
  /**
   * https://x.com/n_seitan/status/1841082493279355009
   */
  public static final ColorValue VIVID_RED = new NamelessColorValue(221, 0, 60);

  /**
   * https://x.com/n_seitan/status/1841082493279355009
   */
  public static final ColorValue VIVID_BLUE = new NamelessColorValue(49, 93, 170);

  /**
   * https://x.com/n_seitan/status/1841082493279355009
   */
  public static final ColorValue VIVID_GREEN = new NamelessColorValue(60, 160, 60);

  /**
   * https://x.com/n_seitan/status/1841082493279355009
   */
  public static final ColorValue VIVID_YELLOW = new NamelessColorValue(255, 200, 0);

  /**
   * https://x.com/yamatotajimaya/status/1996916690073039205
   */
  public static final ColorValue BACKGROUND_WHITE_FOR_CRT = new NamelessColorValue(204, 204, 204);

  /**
   * Constructor
   * @param r Red([0,255])
   * @param g Green([0,255])
   * @param b Blue([0,255])
   */
  private NamelessColorValue(int r, int g, int b) {
    super(r, g, b);
  }
}
