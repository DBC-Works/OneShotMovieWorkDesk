/**
 * Abstract color name
 */
public abstract class ColorName {
  /**
   * Name
   */
  private final String name;

  /**
   * Red(0 - 255)
   */
  private final int red;

  /**
   * Green(0 - 255)
   */
  private final int green;

  /**
   * Blue(0 - 255)
   */
  private final int blue;

  /**
   * Constructor
   * @param n name
   * @param r red([0,255])
   * @param g green([0,255])
   * @param b blue([0,255])
   */
  protected ColorName(final String n, final int r, final int g, final int b) {
    name = n;
    red = r;
    green = g;
    blue = b;
  }

  /**
   * Get name
   * @return name
   */
  public final String getName() {
    return name;
  }

  /**
   * Get red value
   * @return red([0,255])
   */
  public final int getRed() {
    return red;
  }

  /**
   * Get green value
   * @return green([0,255])
   */
  public final int getGreen() {
    return green;
  }

  /**
   * Get blue value
   * @return blue([0,255])
   */
  public final int getBlue() {
    return blue;
  }

  /**
   * Get hue value
   * @return hue([0,360])
   */
  public final float getHue() {
    if (red == green && green == blue) {
      return 0;
    }

    /*
     * If R is max, H = 60 × ((G - B) ÷ (MAX - MIN))
     * If G is max, H = 60 × ((B - R) ÷ (MAX - MIN)) + 120
     * If B is max, H = 60 × ((R - G) ÷ (MAX - MIN)) + 240
     */
    final float diff = getMax() - getMin();
    float hue = 0;
    if (blue <= red && green <= red) {
      hue = 60 * ((green - blue) / diff);
    } else if (blue <= green && red <= green) {
      hue = 60 * ((blue - red) / diff) + 120;
    } else {
      hue = 60 * ((red - green) / diff) + 240;
    }
    return hue < 0 ? hue + 360 : hue;
  }

  /**
   * Get saturation value
   * @return saturation([0,1])
   */
  public final float getSaturation() {
    final var max = getMax();
    return (max - getMin()) / (float)max;
  }

  /**
   * Get saturation value as integer
   * @return saturation([0,100])
   */
  public final int getSaturationAsInt() {
    return Math.round(getSaturation() * 100);
  }

  /**
   * Get brightness value
   * @return brightness([0,1])
   */
  public final float getBrightness() {
    return getMax() / 255.0f;
  }

  /**
   * Get brightness value as integer
   * @return brightness([0,100])
   */
  public final int getBrightnessAsInt() {
    return Math.round(getBrightness() * 100);
  }

  @Override
  public String toString() {
    return String.format("%s(%d, %d, %d)", name, red, green, blue);
  }

  private int getMax() {
    return Math.max(Math.max(red, green), blue);
  }

  private int getMin() {
    return Math.min(Math.min(red, green), blue);
  }
}
