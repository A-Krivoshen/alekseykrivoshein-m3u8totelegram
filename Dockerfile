FROM jrottenberg/ffmpeg:4.3-ubuntu

# Установка необходимых пакетов
RUN apt-get update && apt-get install -y python3-pip && \
    pip3 install requests

# Копируем скрипт
COPY stream_to_rtmp.sh /usr/local/bin/stream_to_rtmp.sh
RUN chmod +x /usr/local/bin/stream_to_rtmp.sh

# Команда по умолчанию
ENTRYPOINT ["/usr/local/bin/stream_to_rtmp.sh"]
