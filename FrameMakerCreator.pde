/**
 * FrameMakerCreator class
 */
final class FrameMakerCreator {
  FrameMaker createSampleMaker() {
    return new FrameMaker() {
      float t;

      {
      }

      void setup() {
        noFill();
        colorMode(HSB, 1, 1, 1, 1);
        blendMode(ADD);
        noiseSeed(128);
      }

      void draw() {
        background(0);
        translateToCenter();
        rotate(t);
        var H = height * .5;

        StreamUtilities.INSTANCE.arithmeticProgression(-TAU, TAU, .05)
          .map((d) -> {
            var f = (float) d.doubleValue();
            var n = noise(t);
            var m = noise(n, f);
            return List.of(
              n,
              n * m,
              cos(sin(t) * f) * sin(f) * sin(n),
              sin(sin(t) * f) * cos(f) * sin(n),
              10 * tan(t * f / 10) * n
            );
          })
          .forEach((x) -> {
            stroke(x.get(0), x.get(1), 1, 1.0/3);
            rotate(.05);
            strokeWeight(4);
            circle(H * x.get(2), H * x.get(3), H / x.get(4));
            strokeWeight(1);
            circle(H * x.get(2), H * x.get(3), H / x.get(4));
            t += .000005;
          });
      }
    };
  }
}
