---
layout: page
title: "FFmpeg audio/video trans/coding"
tagline: "Personal notes about using FFmpeg for transcoding audio & video"
category : notes
tags : [draft, wide]
published: true
---

* [transcode-x265.fabic.sh](https://github.com/fabic/bash-it/blob/master/fabic/bin/transcode-x265.fabic.sh)
* [transcode.sh](https://github.com/fabic/bash-it/blob/master/fabic/bin/transcode.sh)
* [resub.sh](https://github.com/fabic/bash-it/blob/master/fabic/bin/resub.sh)

* __TODO:__ VP9/webm encoding notes.
* __TODO:__ x264 encoding notes.
* __TODO:__ x265 encoding notes.

## On video encoding

* [Comparing video codecs and containers for archives, by Peter B., Hermann Lewetz and Marion Jaks (2013-2015)](http://download.das-werkstatt.com/pb/mthk/info/video/comparison_video_codecs_containers.html)
* [A short guide to choosing a digital format for video archiving masters, by Emanuel Lorrain (2014)](https://www.scart.be/?q=en/content/short-guide-choosing-digital-format-video-archiving-masters)
* [File formats for archiving @ ethz.ch](https://documentation.library.ethz.ch/display/DD/File+formats+for+archiving)
* [About GOP (Group Of Pictures)](https://www.researchgate.net/post/What_is_the_difference_between_Group_of_Pictures_GOP_and_video) and [this one](http://www.tiliam.com/Blog/2015/07/06/effective-use-long-gop-video-codecs "Effective use of Long GOP Video Codecs")

## H265 video encoding

* [x265 command line options](https://x265.readthedocs.io/en/latest/cli.html)
* **Must read:** [Understanding Rate Control Modes (x264, x265, vpx)](https://slhck.info/video/2017/03/01/rate-control.html)

### High quality H265 CRF-24

```bash
$ time \
    ffmpeg -loglevel info -stats -i jardin-eden-08.mov \
      -codec:v libx265 -preset slow -threads 1 -vf format=yuv420p \
      -crf 24 -bf 2 -flags +cgop -g 60 \
      -c:a libmp3lame -q:a 0 \
      -movflags faststart \
      -y jardin-eden-08.h265.high-profile.crf-24.mov
```

## Extracting streams

Extract selected streams from a source __video.mkv__, typically the video track
and one of the audio tracks (use `ffprobe` to display the streams first) :

```bash
ffprobe -hide_banner video.mkv

ffmpeg -loglevel info -i video.mkv \
  -map 0:0 -map 0:2 \
  -c copy test.mkv
```

¿ `-itsoffset 1.0` what is ?

```bash
ffmpeg -i video1.mkv -itsoffset 1.0 -i video2.avi \
  -c copy -map 0:v:0 -map 0:a:0 -map 1:a:0 -map 0:s:0 \
  test.mkv
```

## Video scaling `-vf scale=-1:720`

```bash
ffmpeg -i video.mp4 \
  -codec:v libx264 -profile:v high -preset slow \
  -b:v 4000k -maxrate 8000k -bufsize 32000k -vf scale=-1:720 -threads 0 \
  -codec:a aac -b:a 128k \
  test.mp4
```

## Extract slices of video

Extract a slice of __video.mkv__ without re-encoding the streams (copy) :

```bash
ffmpeg -i video.mkv -ss 00:46:00 -to 00:46:39 -c copy test.mkv
```

Extract a slice of __video.mkv__ `-ss 00:20:58 -to 00:21:18`, with subtitles
included `-c:s mov_text`

* <https://trac.ffmpeg.org/wiki/HowToBurnSubtitlesIntoVideo>
* Optional: `-map 0:0 -map 0:1 -map 0:2` to select streams.

```bash
ffmpeg -loglevel info -stats -i video.mp4 \
  -ss 00:20:58.250 -to 00:21:18.500 \
  -map 0:0 -map 0:1 -map 0:2 \
  -codec:v libx264 -profile:v main -level 3.1 -preset veryslow \
  -crf 18 -bf 2 -flags +cgop -pix_fmt yuv420p -threads 0 \
  -codec:a aac -strict -2 -b:a 160k -r:a 44000 \
  -c:s mov_text -movflags faststart \
    test.mp4
```

Likewise with `-vf subtitles=video.mp4` for reading subtitles embedded in the
source video, and encode these in the output video as _hardsubs_ subtitles :

```bash
ffmpeg -loglevel info -stats \
  -i video.mp4 -ss 00:20:59.5 -to 00:21:17.5 \
  -codec:v libx264 -profile:v main -level 3.1 -preset veryslow \
  -crf 18 -bf 2 -flags +cgop -pix_fmt yuv420p \
  -vf subtitles=video.mp4 -threads 0 \
  -codec:a aac -strict -2 -b:a 160k -r:a 44000 \
  -movflags faststart \
    test.mp4
```

¿ why such a high audio bitrate ?

```bash
ffmpeg -i video.mkv -ss 00:45:59 -to 00:46:40 \
  -codec:v libx264 -crf 21 -bf 2 -flags +cgop -pix_fmt yuv420p \
  -codec:a aac -strict -2 -b:a 384k -r:a 48000 \
  -movflags faststart \
  test.mp4
```

High profile, slow preset, CRF 18... :

```bash
ffmpeg -i video.mkv -ss 00:45:59 -to 00:46:40 \
  -codec:v libx264 -profile:v high -preset slow -crf 18 -bf 2 \
  -flags +cgop -pix_fmt yuv420p -vf scale=-1:478 -threads 0 \
  -codec:a aac -strict -2 -b:a 192k -r:a 44000 \
  -movflags faststart \
  test.mkv
```

Best compatibility with mobile devices.
Main profile level 3.1, very slow preset, CRF 21 :

```bash
ffmpeg -i video.mkv \
  -codec:v libx264 -profile:v main -level 3.1 -preset veryslow -crf 21 -bf 2 \
  -flags +cgop -pix_fmt yuv420p -vf scale=-1:478 -b:v 3072 -threads 0 \
  -codec:a aac -strict -2 -b:a 160k -r:a 44000 \
  -movflags faststart  test.mp4
```

### Adding subtitles

* <https://trac.ffmpeg.org/wiki/HowToBurnSubtitlesIntoVideo>
* Using `-sub_charenc latin1` to specify the encoding of the input subtitles `.srt` file.
* Using `-map X:N` to select a few of the available streams (ex. discard some audio/subtitles
  tracks).
* <https://stackoverflow.com/a/33289845>
* [FFmpeg guide : Set character encoding (wikibooks.org)](https://en.wikibooks.org/wiki/FFMPEG_An_Intermediate_Guide/subtitle_options#Set_Subtitles_Character_Encoding_Conversion)

```bash
ffmpeg -loglevel info \
  -i video.mp4 \
  -sub_charenc latin1 -i "video-subs.srt" \
  -map 0:0 -map 0:1 -map 1:0 \
  -c:v copy -c:a copy -c:s mov_text \
    output-video.alt.subs.mp4
```

## Fetching MP2T video streams

Used `streamlink` to fetch the MP2T video stream :

```bash
streamlink --loglevel info \
  -o ~/Downloads/video.mp4 \
  https://s18.escdn.co/hls/jg6n...,ifzp...,tnzp...,.urlset/master.m3u8 \
  best
```


## Read media metadata with `ffprobe`

```bash
ffprobe -v quiet -print_format json -show_streams -show_format video.mkv

ffprobe -v info -hide_banner video.mkv
```

## Generate thumbnail image

```bash
ffmpeg -ss 10 -i video.mp4     \
  -vf "thumbnail,scale=-1:480" \
  -frames:v 1                  \
  -vsync vfr                   \
  -y thumbnail.jpg </dev/null
```


### Adding thumbnail image to video file using `mp4art`

```bash
mp4art -zv --add thumbnail.jpg video.mp4
```


## Pointers

* [SO: Re-encoding video library in x265 (HEVC) with no quality loss](https://unix.stackexchange.com/a/248711)
* [2017: Understanding Rate Control Modes (x264, x265, vpx) by Werner Robitza / slhck.info](https://slhck.info/video/2017/03/01/rate-control.html) __[must read]__
* [FourCC : four-character code @ wikipedia](https://en.wikipedia.org/wiki/FourCC)
* FourCC: [about 10-bit and 16-bit YUV Video Formats](https://docs.microsoft.com/en-us/windows/desktop/medfound/10-bit-and-16-bit-yuv-video-formats) @ M$
  _(must read: very detailed and accurate information)_
* [2013 forum thread “Lossless (10 Bit RGB 444) and (10 Bit YUV 422) Compression Codec's” (nice discussion with some useful details)](https://forum.videohelp.com/threads/361133-Lossless-%2810-Bit-RGB-444%29-and-%2810-Bit-YUV-422%29-Compression-Codec-s)


## EOF

