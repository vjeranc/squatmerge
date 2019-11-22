#!/usr/bin/env bash

for f in *.mp4; \
do \
  flnm=`basename $f .mp4`
  duration=`ffprobe -i $f 2>&1 | rg "Duration" | rg "\d{2}:\d{2}:\d{2}\.\d{2}" --only-matching | sed 's/\./,/'`
  weight=`echo $f | rg "\d+\.\d" --only-matching`
  workoutdate=`echo $f | rg "\d{8}" --only-matching`
  workoutdate=`date +'%b %d, %Y' -d$workoutdate`
  yr=${d:0:4}
  mo=${d:4:2}
  dy=${d:6:2}
  echo $duration $weight $workoutdate
  read -r -d '' srtcontent << EOM
1
00:00:00 --> $duration
$weight kg
$workoutdate

EOM
  echo "$srtcontent" > $flnm.srt
done
