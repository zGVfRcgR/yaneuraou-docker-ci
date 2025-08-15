FROM ubuntu:24.04

ARG OPT
WORKDIR /app

# 必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        git \
        clang \
        lld \
    && rm -rf /var/lib/apt/lists/*

# やねうら王ソースを取得
RUN git clone --depth 1 https://github.com/yaneurao/YaneuraOu.git src

# ビルドディレクトリに移動してコンパイル
WORKDIR /app/src/source
RUN make ARCH=x86-64-avx2 OPT=${OPT} -j$(nproc)

# 実行時のカレントディレクトリを設定
WORKDIR /app/src/source
CMD ["./YaneuraOu"]
