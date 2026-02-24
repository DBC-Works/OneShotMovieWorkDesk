/**
 * Binding priority type
 */
enum BindingPriorityType {
  SPEED,
  BALANCE,
  QUALITY;
}

/**
 * FrameRecorder abstract class
 */
abstract class FrameRecorder {

  private final BindingPriorityType bindingPriority;

  protected FrameRecorder(BindingPriorityType priority) {
    bindingPriority = priority;
  }
  protected FrameRecorder() {
    this(BindingPriorityType.BALANCE);
  }

  abstract void recordFrame();
  abstract void bindTo(String fileName, int frameRate);
  abstract void bindTo(String fileName, String soundFilePath, int frameRate);
  abstract void finish();

  protected final String getRecordPath() {
    return MessageFormat.format(
      "{0}{1}img",
      sketchPath(),
      File.separator
    );
  }

  protected final String makeImageFileName(String fileNameFormat) {
    return MessageFormat.format(
      "img{0}{1}",
      File.separator,
      fileNameFormat
    );
  }

  protected final BindingPriorityType getBindingPriority() {
    return bindingPriority;
  }
}

/**
 * Synchronous frame recorder
 */
final class SyncFrameRecorder extends FrameRecorder {
  private final String imgExt;
  private final String frameFormat;

  SyncFrameRecorder(String ext, BindingPriorityType priority) {
    super(priority);
    imgExt = ext;
    frameFormat = makeImageFileName("########." + ext);
  }
  SyncFrameRecorder(String ext) {
    super();
    imgExt = ext;
    frameFormat = makeImageFileName("########." + ext);
  }

  void recordFrame() {
    saveFrame(frameFormat);
  }

  void bindTo(String fileName, int frameRate) {
    bindTo(fileName, null, frameRate);
  }

  void bindTo(String fileName, String soundFilePath, int frameRate) {
    new FrameBinder(fileName, getRecordPath(), imgExt, soundFilePath, frameRate).bind();
  }

  void finish() {
  }
}

/**
 * Asynchronous frame recorder
 */
final class AsyncFrameRecorder extends FrameRecorder {
  private final ExecutorService executor = Executors.newCachedThreadPool();
  private final List<Future<?>> futures = new ArrayList<Future<?>>();

  AsyncFrameRecorder(BindingPriorityType priority) {
    super(priority);
  }
  AsyncFrameRecorder() {
    super();
  }

  void recordFrame() {
    if (executor.isShutdown()) {
      return;
    }

    loadPixels();

    final var savePixels = Arrays.copyOf(pixels, pixels.length);
    final var saveFrameCount = frameCount;
    final var saveTask = new Runnable() {
      public void run() {
        final var frameImage = createImage(width, height, HSB);
        frameImage.pixels = savePixels;
        final var saveFilePath = makeImageFileName(formatFileName(saveFrameCount));
        frameImage.save(saveFilePath);
      }
    };

    final var it = futures.iterator();
    while (it.hasNext()) {
      final var f = it.next();
      if (f.isDone()) {
        it.remove();
      }
    }
    futures.add(executor.submit(saveTask));
  }

  void bindTo(String fileName, int frameRate) {
    bindTo(fileName, null, frameRate);
  }

  void bindTo(String fileName, String soundFilePath, int frameRate) {
    FrameBinder.FFMpegPreset preset;
    switch (getBindingPriority()) {
      case SPEED:
        preset = FrameBinder.FFMpegPreset.FASTER;
        break;
      case QUALITY:
        preset = FrameBinder.FFMpegPreset.SLOWER;
        break;
      default:
        preset = FrameBinder.FFMpegPreset.MEDIUM;
        break;
    }
    new FrameBinder(fileName, getRecordPath(), "jpg", soundFilePath, frameRate, preset).bind();
  }

  void finish() {
    final var expectFilePath = new File(getRecordPath(), formatFileName(frameCount));
    for (var i = 0; i < 10; ++i) {
      try {
        Thread.sleep(1000);
      }
      catch (InterruptedException e) {
      }
      if (expectFilePath.exists()) {
        break;
      }
    }

    for (var f : futures) {
      if (f.isDone() == false && f.isCancelled() == false) {
        try {
          f.get();
        }
        catch (InterruptedException e) {
        }
        catch (ExecutionException e) {
        }
      }
    }
    if (executor.isShutdown() == false) {
      executor.shutdown();
      try {
        if (executor.awaitTermination(5, TimeUnit.SECONDS) == false) {
          executor.shutdownNow();
          executor.awaitTermination(5, TimeUnit.SECONDS);
        }
      }
      catch (InterruptedException e) {
        executor.shutdownNow();
      }
    }
  }

  private String formatFileName(long frameCount) {
    return String.format("%08d.jpg", frameCount);
  }
}

enum FrameRecorderType {
  SyncTgaRecorder,
  SyncPngRecorder,
  AsyncRecorder;
}

FrameRecorder createFrameRecorderInstanceOf(FrameRecorderType type) {
  switch (type) {
    case SyncTgaRecorder:
      return new SyncFrameRecorder("tga");
    case SyncPngRecorder:
      return new SyncFrameRecorder("png");
    case AsyncRecorder:
      return new AsyncFrameRecorder();
    default:
      throw new RuntimeException();
  }
}
