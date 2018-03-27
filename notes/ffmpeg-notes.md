---
layout: page
title: "FFmpeg audio/video trans/coding"
tagline: "Personal notes about using FFmpeg for transcoding audio & video"
#category : notes
tags : [draft, wide]
published: false
---

* [transcode-x265.fabic.sh](https://github.com/fabic/bash-it/blob/master/fabic/bin/transcode-x265.fabic.sh)
* [transcode.sh](https://github.com/fabic/bash-it/blob/master/fabic/bin/transcode.sh)

* __TODO:__ VP9/webm encoding notes.
* __TODO:__ x264 encoding notes.
* __TODO:__ x265 encoding notes.

```bash
ffprobe -hide_banner video.mkv

ffmpeg -loglevel info -i video.mkv \
  -map 0:0 -map 0:2 \
  -c copy test.mkv
```

```bash
ffmpeg -i video1.mkv -itsoffset 1.0 -i video2.avi \
  -c copy -map 0:v:0 -map 0:a:0 -map 1:a:0 -map 0:s:0 \
  test.mkv
```

```bash
ffmpeg -i video.mp4 \
  -codec:v libx264 -profile:v high -preset slow \
  -b:v 4000k -maxrate 8000k -bufsize 32000k -vf scale=-1:720 -threads 0 \
  -codec:a aac -b:a 128k \
  test.mp4
```

```bash
ffmpeg -i video.mkv -ss 00:46:00 -to 00:46:39 -c copy test.mkv
```

```bash
ffmpeg -i video.mkv -ss 00:45:59 -to 00:46:40 \
  -codec:v libx264 -crf 21 -bf 2 -flags +cgop -pix_fmt yuv420p \
  -codec:a aac -strict -2 -b:a 384k -r:a 48000 \
  -movflags faststart \
  test.mp4
```

```bash
ffmpeg -i video.mkv -ss 00:45:59 -to 00:46:40 \
  -codec:v libx264 -profile:v high -preset slow -crf 18 -bf 2 \
  -flags +cgop -pix_fmt yuv420p -vf scale=-1:478 -threads 0 \
  -codec:a aac -strict -2 -b:a 192k -r:a 44000 \
  -movflags faststart \
  test.mkv
```

```bash
ffmpeg -i video.mkv \
  -codec:v libx264 -profile:v main -level 3.1 -preset veryslow -crf 21 -bf 2 \
  -flags +cgop -pix_fmt yuv420p -vf scale=-1:478 -b:v 3072 -threads 0 \
  -codec:a aac -strict -2 -b:a 160k -r:a 44000 \
  -movflags faststart  test.mp4
```

### Add subtitles

```bash
ffmpeg -loglevel info \
  -i st_voyager_s05e26.mp4 \
  -sub_charenc latin1 -i "Star Trek - Voyager - 5x26 - Equinox Part 1.EN.srt" \
  -map 0:0 -map 0:1 -map 1:0 \
  -c:v copy -c:a copy -c:s mov_text \
  st_voyager_s05e26.subs-en.mp4
```

Used `streamlink` to fetch the MP2T video stream :

```bash
streamlink --loglevel info \
  -o ~/Downloads/st_voyager_s05e25.mp4 \
  https://s18.escdn.co/hls/jg6n...,ifzp...,tnzp...,.urlset/master.m3u8 \
  best
```

* <https://stackoverflow.com/a/33289845>
* [FFmpeg guide : Set character encoding (wikibooks.org)](https://en.wikibooks.org/wiki/FFMPEG_An_Intermediate_Guide/subtitle_options#Set_Subtitles_Character_Encoding_Conversion)

### ffprobe

```bash
ffprobe -v quiet -print_format json -show_streams -show_format video.mkv

ffprobe -v info -hide_banner video.mkv
```

### Generate thumbnail image

```bash
ffmpeg -ss 10 -i video.mp4     \
  -vf "thumbnail,scale=-1:480" \
  -frames:v 1                  \
  -vsync vfr                   \
  -y thumbnail.jpg </dev/null
```

#### Adding thumbnail image to video file using `mp4art`

```bash
mp4art -zv --add thumbnail.jpg video.mp4
```

## Pointers

* [SO: Re-encoding video library in x265 (HEVC) with no quality loss](https://unix.stackexchange.com/a/248711)

## EOF

