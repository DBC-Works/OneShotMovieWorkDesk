# OneShotMovieWorkDesk

OneShotMovieWorkDesk is a Processing sketch for edit to record drawing results.

## Requirements

OneShotMovieWorkDesk needs [Processing 4.4.6 or later](https://processing.org/) to run.

You can use [Visual Studio Code](https://azure.microsoft.com/en-us/products/visual-studio-code) with [Processing VSCode Extension](https://marketplace.visualstudio.com/items?itemName=processing-foundation.processing-vscode-extension)

If you want to make a movie file immediately, you need to install [FFmpeg](https://ffmpeg.org/) and set up your path for FFmpeg executable.

## Usage

1. Create a new class that extends the `FrameMaker` abstract class.
2. Edit the beginning of the `settings` method in `OneShotMovieWorkDesk.pde` to set up the movie.
   - Dimension of the display window
   - Frame maker class to create frames
   - Frame rate per second
   - Bind frames to movie file immediately
   - Sound file path that play and merge into generated movie(option)
3. Run.

## Rules

### Commit message format

[Conventional Commits](https://www.conventionalcommits.org/)

## License

MIT
