yum-config-manager --add-repo http://www.nasm.us/nasm.repo 1>/dev/null
yum install autoconf automake bzip2 cmake freetype-devel gcc gcc-c++ git libtool make mercurial nasm pkgconfig zlib-devel -y 1>/dev/null
mkdir ./ffmpeg_sources 1>/dev/null
cd ./ffmpeg_sources 1>/dev/null

echo building yasm
curl -O http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz 1>/dev/null
tar xzvf yasm-1.3.0.tar.gz 1>/dev/null
cd yasm-1.3.0 1>/dev/null
./configure --prefix="/opt/ffmpeg_build" --bindir="/opt/bin" 1>/dev/null
make 1>/dev/null
make install

echo building x264
cd /opt/ffmpeg_sources 1>/dev/null
git clone --depth 1 http://git.videolan.org/git/x264 1>/dev/null
cd x264 1>/dev/null
PKG_CONFIG_PATH="/opt/ffmpeg_build/lib/pkgconfig" ./configure --prefix="/opt/ffmpeg_build" --bindir="/opt/bin" --enable-static 1>/dev/null
make 1>/dev/null
make install

echo building x265
cd /opt/ffmpeg_sources 1>/dev/null
hg clone https://bitbucket.org/multicoreware/x265 1>/dev/null
cd /opt/ffmpeg_sources/x265/build/linux 1>/dev/null
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/opt/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source 1>/dev/null
make 1>/dev/null
make install

echo building fdk-aac
cd /opt/ffmpeg_sources 1>/dev/null
git clone --depth 1 https://github.com/mstorsjo/fdk-aac 1>/dev/null
cd fdk-aac 1>/dev/null
autoreconf -fiv 1>/dev/null
./configure --prefix="/opt/ffmpeg_build" --disable-shared 1>/dev/null
make 1>/dev/null
make install

echo building lame
cd /opt/ffmpeg_sources 1>/dev/null
curl -L -O http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz 1>/dev/null
tar xzvf lame-3.99.5.tar.gz 1>/dev/null
cd lame-3.99.5 1>/dev/null
./configure --prefix="/opt/ffmpeg_build" --bindir="/opt/bin" --disable-shared --enable-nasm 1>/dev/null
make 1>/dev/null
make install

echo building opus
cd /opt/ffmpeg_sources 1>/dev/null
curl -O https://archive.mozilla.org/pub/opus/opus-1.1.5.tar.gz 1>/dev/null
tar xzvf opus-1.1.5.tar.gz 1>/dev/null
cd opus-1.1.5 1>/dev/null
./configure --prefix="/opt/ffmpeg_build" --disable-shared 1>/dev/null
make 1>/dev/null
make install

echo building libogg
cd /opt/ffmpeg_sources 1>/dev/null
curl -O http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz 1>/dev/null
tar xzvf libogg-1.3.2.tar.gz 1>/dev/null
cd libogg-1.3.2 1>/dev/null
./configure --prefix="/opt/ffmpeg_build" --disable-shared 1>/dev/null
make 1>/dev/null
make install

echo building libvorbis
cd /opt/ffmpeg_sources 1>/dev/null
curl -O http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.4.tar.gz 1>/dev/null
tar xzvf libvorbis-1.3.4.tar.gz 1>/dev/null
cd libvorbis-1.3.4 1>/dev/null
./configure --prefix="/opt/ffmpeg_build" --with-ogg="/opt/ffmpeg_build" --disable-shared 1>/dev/null
make 1>/dev/null
make install

echo building libvpx
cd /opt/ffmpeg_sources 1>/dev/null
git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git 1>/dev/null
cd libvpx 1>/dev/null
./configure --prefix="/opt/ffmpeg_build" --disable-examples  --as=yasm 1>/dev/null
PATH="/opt/bin:$PATH" make 1>/dev/null
make install

echo building ffmpeg
cd /opt/ffmpeg_sources
curl -O http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PKG_CONFIG_PATH="/opt/ffmpeg_build/lib/pkgconfig" ./configure --prefix="/opt/ffmpeg_build" --extra-cflags="-I/opt/ffmpeg_build/include" --extra-ldflags="-L/opt/ffmpeg_build/lib -ldl" --bindir="/opt/bin" --pkg-config-flags="--static" --enable-gpl --enable-nonfree --enable-libfdk_aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265
make
make install
hash -r
