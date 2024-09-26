#!/bin/bash

# Проверка наличия необходимых аргументов
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
  echo "Usage: $0 <M3U8_URL> <RTMP_URL> <RTMP_KEY> <eqon/eqoff>"
  exit 1
fi

M3U8_URL=$1
RTMP_URL=$2
RTMP_KEY=$3
EQ=$4
FULL_RTMP_URL="$RTMP_URL/$RTMP_KEY"

# Команда для трансляции с эквалайзером или без
if [ "$EQ" == "eqon" ]; then
  # Трансляция с эквалайзером
  ffmpeg -re -i "$M3U8_URL" \
    -filter_complex "[0:a]showwaves=s=1280x720:mode=line:colors=blue,format=yuv420p[v]" \
    -map "[v]" -map 0:a \
    -c:v libx264 -preset veryfast -tune zerolatency -c:a aac -ar 44100 -b:a 128k \
    -f flv "$FULL_RTMP_URL"
else
  # Трансляция без эквалайзера
  ffmpeg -re -i "$M3U8_URL" \
    -c:v copy -c:a aac -ar 44100 -b:a 128k \
    -f flv "$FULL_RTMP_URL"
fi
