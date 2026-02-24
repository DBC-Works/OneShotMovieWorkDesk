import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Frame binder
 */
public final class FrameBinder {
  /**
   * FFmpeg preset options
   */
  public enum FFMpegPreset {
    ULTRAFAST("ultrafast"),
    SUPERFAST("superfast"),
    VERYFAST("veryfast"),
    FASTER("faster"),
    FAST("fast"),
    MEDIUM("medium"),
    SLOW("slow"),
    SLOWER("slower"),
    VERYSLOW("veryslow");

    private final String preset;

    FFMpegPreset(String preset) {
      this.preset = preset;
    }

    @Override
    public String toString() {
      return preset;
    }
  }

  private final String movieFileName;
  private final String path;
  private final String imgExt;
  private final String soundFilePath;
  private final int rate;
  private final FFMpegPreset preset;

  /**
   * constructor
   * @param fileName   File name of movie file to bind
   * @param targetPath Path where image files exist
   * @param ext        Extension of target image file name
   * @param soundFile  Sound file path
   * @param frameRate  Movie file frame rate(per second)
   * @param preset     FFmpeg preset option
   */
  public FrameBinder(
    String fileName,
    String targetPath,
    String ext,
    String soundFile,
    int frameRate,
    FFMpegPreset preset
  ) {
    movieFileName = fileName;
    path = targetPath;
    imgExt = ext;
    soundFilePath = soundFile;
    rate = frameRate;
    this.preset = preset;
  }

  /**
   * constructor
   * @param fileName   File name of movie file to bind
   * @param targetPath Path where image files exist
   * @param ext        Extension of target image file name
   * @param soundFile  Sound file path
   * @param frameRate  Movie file frame rate(per second)
   */
  public FrameBinder(
    String fileName,
    String targetPath,
    String ext,
    String soundFile,
    int frameRate
  ) {
    this(fileName, targetPath, ext, soundFile, frameRate, FFMpegPreset.SLOWER);
  }

  /**
   * Bind image files to a movie file
   */
  public void bind() {
    try {
      final var imgDir = new File(path);

      final var movie = new File(imgDir, movieFileName);
      if (movie.exists()) {
        movie.delete();
      }

      execFfmpeg(imgDir);
      deleteFrames(imgDir);
    } catch (IOException e) {
      e.printStackTrace();
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
  }

  private List<String> createCommandLineParam() {
    final var command = new ArrayList<String>(List.of(
      "ffmpeg",
      "-framerate",
      Integer.toString(rate),
      "-i",
      String.format("%%08d.%s", imgExt)
    ));
    if (soundFilePath != null) {
      command.addAll(List.of("-i", soundFilePath));
      final var compressOptions = List.of(
        "-codec:a",
        "aac",
        "-b:a",
        "320k"
      );
      final var copyOptions = List.of(
        "-codec:a",
        "copy"
      );
      command.addAll(
        soundFilePath.toLowerCase().endsWith(".wav")
          ? compressOptions
          : copyOptions);
    }
    command.addAll(List.of(
      "-pix_fmt",
      "yuv420p",
      "-r",
      Integer.toString(rate),
      "-preset",
      preset.toString(),
      movieFileName
    ));

    return List.copyOf(command);
  }

  private void execFfmpeg(File imgDir) throws IOException, InterruptedException {
    final var processBuilder = new ProcessBuilder(createCommandLineParam());
    processBuilder.redirectErrorStream(true);
    processBuilder.inheritIO();
    processBuilder.directory(imgDir);
    final var process = processBuilder.start();
    process.waitFor();
    process.destroy();
  }

  private void deleteFrames(File imgDir) {
    final var files = imgDir.listFiles(new FileFilter() {
      public boolean accept(File pathname) {
        return pathname.getName().endsWith(imgExt);
      }
    });
    for (var file : files) {
      file.delete();
    }
  }
}
