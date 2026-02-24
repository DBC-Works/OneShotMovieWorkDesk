/**
 * Screen size
 */
public enum ScreenSizeType {
  /**
   * 4K(3840x2160)
   */
  FOUR_K(3840, 2160),

  /**
   * WQHD(2560x1440)
   */
  WQHD(2560, 1440),

  /**
   * Full HD(1920x1080)
   */
  FULL_HD(1920, 1080),

  /**
   * HD(1280x720)
   */
  HD(1280, 720),

  /**
   * SD(640x480)
   */
  SD(640, 480);

  /**
   * Width of screen
   */
  private final int width;

  /**
   * Height of screen
   */
  private final int height;

  /**
   * constructor
   * @param width Screen width
   * @param height Screen height
   */
  ScreenSizeType(int width, int height) {
    this.width = width;
    this.height = height;
  }

  /**
   * Get width of screen
   * @return Screen width
   */
  public int getWidth() {
    return width;
  }

  /**
   * Get height of screen
   * @return Screen height
   */
  public int getHeight() {
    return height;
  }
}
