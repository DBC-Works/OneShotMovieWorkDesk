import java.util.PrimitiveIterator;
import java.util.Spliterator;
import java.util.Spliterators;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

/**
 * Stream utilities
 */
public final class StreamUtilities {
  public static final StreamUtilities INSTANCE = new StreamUtilities();

  private StreamUtilities() {
  }

  /**
   * Generate arithmetic progression stream
   * @param min      Minimum value
   * @param max      Max value
   * @param interval Interval value
   * @return Arithmetic progression stream
   */
  public Stream<Double> arithmeticProgression(double min, double max, double interval) {
    assert min <= max && 0 < interval;

    var it = new PrimitiveIterator.OfDouble() {
        private double v = min;
        public boolean hasNext() {
          return v <= max;
        }
        public double nextDouble() {
          var i = v;
          v += interval;
          return i;
        }
    };
    return StreamSupport.stream(
      Spliterators.spliteratorUnknownSize(
        it,
        Spliterator.NONNULL | Spliterator.ORDERED | Spliterator.DISTINCT | Spliterator.SORTED
      ),
      false);
  }
}
