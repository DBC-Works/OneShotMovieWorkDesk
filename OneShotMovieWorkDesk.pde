import java.io.FileFilter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Iterator;
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.PrimitiveIterator;
import java.util.Spliterator;
import java.util.Spliterators;
import java.util.stream.StreamSupport;
import java.text.MessageFormat;

import processing.sound.Amplitude;
import processing.sound.SoundFile;

private String renderedMovieFilePath;
private String soundFilePath;

private FrameMaker maker;
private float secondsAfterEnd;

private FrameRecorder recorder;
private FrameRecorder getFrameRecorder() {
  return recorder;
}

private SoundFile soundFile;
private SoundFile getSoundFile() {
  return soundFile;
}

private int length;
private int getLength() {
  return length;
}
private int calcLengthFromSoundFile() {
  assert soundFile != null;

  final var duration = soundFile.duration();
  final var s = Math.floor(duration);
  final var ms = duration - s;
  final var lengthMin = (int)Math.floor(s / 60);
  final var lengthSec = (int)s % 60;
  final var lengthFrame = (int)Math.ceil(ms * maker.getExpectedFrameRate());
  return getTotalFrameCount(lengthMin, lengthSec, lengthFrame);
}

private int getTotalFrameCount(int min, int sec, int fr) {
  assert min <= 0 && sec <= 0 && fr <= 0;

  return ((min * 60) + sec) * maker.getExpectedFrameRate() + fr;
}
private Amplitude amplitude;
private Amplitude getAmplitude() {
  assert amplitude != null;

  return amplitude;
}

/**
 * Get progress
 * @return Progress(percentage)
 */
float getProgress() {
  return frameCount / (float)getLength();
}

void settings() {
  // TODO: Set frame maker
  maker = new FrameMakerCreator().createSampleMaker();
  secondsAfterEnd = 2;

  // TODO: Set setting variables
  // soundFilePath = "(Write absolute file path of sound file here and enable this line)";
  // renderedMovieFilePath = "(Write absolute file path of video file here and enable this line)";

  if (soundFilePath != null) {
    soundFile = new SoundFile(this, soundFilePath);
    length = calcLengthFromSoundFile() + (int)(secondsAfterEnd * maker.getExpectedFrameRate());
    amplitude = new Amplitude(this);
    amplitude.input(soundFile);
  } else {
    length = renderedMovieFilePath != null ? getTotalFrameCount(5, 0, 0) : Integer.MAX_VALUE;
  }

  if (renderedMovieFilePath != null) {
    recorder = createFrameRecorderInstanceOf(FrameRecorderType.AsyncRecorder);
  }

  if (soundFile != null) {
    soundFile.play();
  }

  pixelDensity(1);
  final var screenSize = maker.getScreenSize();
  size(screenSize.getWidth(), screenSize.getHeight(), maker.getRenderer());
}

void draw() {
  if (frameCount <= 1) {
    maker.setup();
    frameRate(maker.getExpectedFrameRate());
    smooth();
  }

  if (frameRate <= (maker.getExpectedFrameRate() - 1)) {
    println("(frame dropped at " + frameCount + "(frameRate=" + frameRate + "))");
  }

  maker.draw();
  if (recorder != null) {
    recorder.recordFrame();
  }

  if (getLength() <= frameCount) {
    if (soundFile != null) {
      soundFile.stop();
      soundFile = null;
    }
    if (recorder != null) {
      recorder.finish();
      recorder.bindTo(renderedMovieFilePath, soundFilePath, maker.getExpectedFrameRate());
      recorder = null;
    }
    exit();
  }
}
