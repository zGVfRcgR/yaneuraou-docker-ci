FROM ubuntu:22.04

ARG OPT
WORKDIR /app

RUN apt-get update && \
    apt-get install -y build-essential && \
    rm -rf /var/lib/apt/lists/*

COPY . .

# 評価関数の指定もここで可能
# ARG EVALFILE
# ENV EVALFILE=$EVALFILE

RUN make build ARCH=x86-64-avx2 OPT=${OPT} -j$(nproc)

CMD ["./YaneuraOu"]