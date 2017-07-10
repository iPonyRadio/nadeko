yum-config-manager --add-repo http://www.nasm.us/nasm.repo
yum install autoconf automake bzip2 cmake freetype-devel gcc gcc-c++ git libtool make mercurial nasm pkgconfig zlib-devel -y
mkdir ./ffmpeg_sources
cd ./ffmpeg_sources

curl -O http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar xzvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure --prefix="/opt/ffmpeg_build" --bindir="/opt/bin"
make
make install

cd /opt/ffmpeg_sources
git clone --depth 1 http://git.videolan.org/git/x264
cd x264
PKG_CONFIG_PATH="/opt/ffmpeg_build/lib/pkgconfig" ./configure --prefix="/opt/ffmpeg_build" --bindir="/opt/bin" --enable-static
make
make install

cd /opt/ffmpeg_sources
hg clone https://bitbucket.org/multicoreware/x265
cd /opt/ffmpeg_sources/x265/build/linux
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/opt/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
make
make install

cd /opt/ffmpeg_sources
git clone --depth 1 https://github.com/mstorsjo/fdk-aac
cd fdk-aac
autoreconf -fiv
./configure --prefix="/opt/ffmpeg_build" --disable-shared
make
make install

cd /opt/ffmpeg_sources
curl -L -O http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar xzvf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure --prefix="/opt/ffmpeg_build" --bindir="/opt/bin" --disable-shared --enable-nasm
make
make install

cd /opt/ffmpeg_sources
curl -O https://archive.mozilla.org/pub/opus/opus-1.1.5.tar.gz
tar xzvf opus-1.1.5.tar.gz
cd opus-1.1.5
./configure --prefix="/opt/ffmpeg_build" --disable-shared
make
make install

cd /opt/ffmpeg_sources
curl -O http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz
tar xzvf libogg-1.3.2.tar.gz
cd libogg-1.3.2
./configure --prefix="/opt/ffmpeg_build" --disable-shared
make
make install

cd /opt/ffmpeg_sources
curl -O http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.4.tar.gz
tar xzvf libvorbis-1.3.4.tar.gz
cd libvorbis-1.3.4
./configure --prefix="/opt/ffmpeg_build" --with-ogg="/opt/ffmpeg_build" --disable-shared
make
make install

cd /opt/ffmpeg_sources
git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git
cd libvpx
./configure --prefix="/opt/ffmpeg_build" --disable-examples  --as=yasm
PATH="/opt/bin:$PATH" make
make install

cd /opt/ffmpeg_sources
curl -O http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PKG_CONFIG_PATH="/opt/ffmpeg_build/lib/pkgconfig" ./configure --prefix="/opt/ffmpeg_build" --extra-cflags="-I/opt/ffmpeg_build/include" --extra-ldflags="-L/opt/ffmpeg_build/lib -ldl" --bindir="/opt/bin" --pkg-config-flags="--static" --enable-gpl --enable-nonfree --enable-libfdk_aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265
make
make install
hash -r
