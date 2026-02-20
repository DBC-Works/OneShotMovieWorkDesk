# 3. Use FFmpeg

Date: 2026-02-21

## Status

Accepted

## Context

We need to decide which program or library to use to generate the video.

## Decision

We use [FFmpeg](https://www.ffmpeg.org/).

## Consequences

### Positive

FFmpeg is a well-established, highly functional video creation application.

### Negative

- This is an external program and must be installed separately.
- Since videos are created from still images, a large amount of temporary storage space is required.
