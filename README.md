## Cutting
```bash
while read fn from to; do flnm=`ls "$fn.mp4"`; ffmpeg -nostdin -i "$flnm" -vcodec copy -acodec copy -ss "$from" -to $to "c$fn.mp4"; done < cuts.txt
```

## Srt Files Creation

```bash
./createsrt.sh
```

## Merging subtitles and videos

```bash
for f in *.mp4; do \
flnm=`basename $f .mp4`; \
mkvmerge -o "s$flnm.mp4" $flnm.mp4  --language 0:en --track-name 0:English "$flnm.srt"; \
done;
```

## Merging videos into a LP progression

```bash
ls sc*.mp4 | sort -k2,3g -t '_' > /tmp/concat_order.txt
a=`cat /tmp/concat_order.txt | tr -s '\n' " " | sed 's/ / +/g'`
mkvmerge -o comp.mp4 ${a::-2}
```
