FROM ubuntu
# save time with an updated ubuntu image if debugging
#FROM ubuntu-build
# Install make
RUN apt update && apt install -y make build-essential wget
WORKDIR /tmp/
RUN wget "https://www.thregr.org/~wavexx/software/fIcy/releases/fIcy-1.0.21.tar.gz" && tar -xvzf fIcy-1.0.21.tar.gz && mv fIcy-1.0.21 fIcy
COPY ./fIcy/ /fIcy/
COPY ./keep_running.sh /fIcy/keep_running.sh
RUN chmod u+x /fIcy/keep_running.sh


ARG RECORD_OUTPUT="/recordings/turntable.mp3"
ARG RECORD_SECONDS="11"
ARG RECORD_HOST="192.168.1.244"
ARG RECORD_PORT="8000"
ARG RECORD_MOUNT="/turntable.mp3"


ENV RECORD_OUTPUT=$RECORD_OUTPUT
ENV RECORD_SECONDS=$RECORD_SECONDS
ENV RECORD_HOST=$RECORD_HOST
ENV RECORD_PORT=$RECORD_PORT
ENV RECORD_MOUNT=$RECORD_MOUNT

# Change to /app
WORKDIR /fIcy


RUN make install

#CMD ["fIcy", "-s", ".mp3", "-o", "/recordings/turntable.mp3", "-M", "11", "-d", "192.168.1.244", "8000", "/turntable.mp3"]
CMD ["/bin/bash", "-c", "/fIcy/keep_running.sh ${RECORD_OUTPUT} ${RECORD_SECONDS} ${RECORD_HOST} ${RECORD_PORT} ${RECORD_MOUNT}"]