/**
 * Values realizer
 */
public interface Realizer {
  abstract public Iterator<Float> realize(PApplet applet, Iterator<Float> it);
}

/**
 * Values visualizer
 */
public enum Visualizer implements Realizer {
  /**
   * LINE: length
  */
  LINE() {
    public Iterator<Float> realize(PApplet applet, Iterator<Float> it) {
      assert it.hasNext();

      final var length = it.next() / 2;
      applet.line(-length, 0, length, 0);
      return it;
    }
  },

  /**
   * RECT: width[, height]
   */
  RECT() {
    public Iterator<Float> realize(PApplet applet, Iterator<Float> it) {
      assert it.hasNext();

      final var width = it.next();
      final var height = it.hasNext() ? it.next() : width;
      applet.rect(0, 0, width, height);
      return it;
    }
  },

  /**
   * ROUND_RECT: width[, height[, round]]
   */
  ROUND_RECT() {
    public Iterator<Float> realize(PApplet applet, Iterator<Float> it) {
      assert it.hasNext();

      final var width = it.next();
      final var height = it.hasNext() ? it.next() : width;
      final var round = it.hasNext() ? it.next() : 0f;
      applet.rect(0, 0, width, height, round);
      return it;
    }
  },

  /**
   * REGULAR_POLYGON: radius[, sides]
   */
  REGULAR_POLYGON() {
    public Iterator<Float> realize(PApplet applet, Iterator<Float> it) {
      assert it.hasNext();

      final var r = it.next();
      final var sides = it.hasNext() ? max(3, it.next().intValue()) : 3;

      applet.beginShape();
      IntStream.range(0, sides)
        .mapToObj(i -> i * TWO_PI / sides)
        .forEach(a -> applet.vertex(r * PApplet.cos(a), r * PApplet.sin(a)));
      applet.endShape(CLOSE);

      return it;
    }
  },

  /**
   * CIRCLE: radius
   */
  CIRCLE() {
    public Iterator<Float> realize(PApplet applet, Iterator<Float> it) {
      assert it.hasNext();

      applet.circle(0f, 0f, it.next());
      return it;
    }
  };

  /**
   * Realize the given values using the visualizer
   * @param applet The PApplet instance
   * @param values The collection of values to visualize
   * @return The remaining values
   */
  public Collection<Float> realize(PApplet applet, Collection<Float> values)
  {
    assert values.isEmpty() == false;

    var it = values.iterator();
    final var x = it.next();
    final var y = it.hasNext() ? it.next() : x;

    applet.push();
    applet.rectMode(CENTER);
    applet.ellipseMode(CENTER);
    applet.translate(x, y);
    it = realize(applet, it);
    applet.pop();

    return StreamSupport.stream(
      Spliterators.spliteratorUnknownSize(
        it,
        Spliterator.NONNULL | Spliterator.ORDERED),
      false)
    .toList();
  }

  /**
   * Realize the given values using the visualizer
   * @param applet The PApplet instance
   * @param values The collection of values to visualize
   * @return The remaining values
   */
  abstract public Iterator<Float> realize(PApplet applet, Iterator<Float> it);
}
