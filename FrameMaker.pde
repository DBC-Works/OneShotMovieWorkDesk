/**
 * Frame maker abstract class
 */
abstract class FrameMaker {
  /**
   * Screen size type
   */
  private ScreenSizeType screenSize = ScreenSizeType.HD;

  /**
   * Renderer of this frame maker
   */
  private String renderer = P3D;

  /**
   * Expected frame rate of this frame maker
   */
  private int expectedFrameRate = 24;

  /**
   * Get screen size type
   * @return screen size type
   */
  final ScreenSizeType getScreenSize() {
    return screenSize;
  }

  /**
   * Set screen size
   * @param size screen size type
   */
  protected final void setScreenSize(ScreenSizeType size) {
    screenSize = size;
  }

  /**
   * Get renderer
   * @return renderer
   */
  final String getRenderer() {
    return renderer;
  }

  /**
   * Set renderer
   * @param renderer renderer
   */
  protected final void setRenderer(String renderer) {
    this.renderer = renderer;
  }

  /**
   * Get frame rate
   * @return frame rate
   */
  final int getExpectedFrameRate() {
    return expectedFrameRate;
  }

  /**
   * Set expected frame rate
   * @param frameRate frame rate
   */
  protected final void setExpectedFrameRate(int frameRate) {
    expectedFrameRate = frameRate;
  }

  /**
   * Translate to the center of the screen
   */
  protected final void translateToCenter() {
    translate(getScreenSize().getWidth() / 2, getScreenSize().getHeight() / 2);
  }

  /**
   * Set up frame maker
   */
  abstract void setup();

  /**
   * Draw frame
   */
  abstract void draw();
}
