yum-config-manager --add-repo http://www.nasm.us/nasm.repo 1>/dev/null
yum install autoconf automake build-essential bzip2 cmake file freetype-devel gcc gcc-c++ git libssl-dev libtool make mercurial nasm openssl pkgconfig xmlto zlib-devel -y 1>/dev/null

mkdir ~/ffmpeg_sources 1>/dev/null

echo
echo #
echo Building yasm
echo #
echo

cd ~/ffmpeg_sources 1>/dev/null
curl -O http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz 1>/dev/null
tar xzvf yasm-1.3.0.tar.gz 1>/dev/null
cd yasm-1.3.0 1>/dev/null
./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" 1>/dev/null
make 1>/dev/null
make install 1>/dev/null

echo
echo #
echo Building x264
echo #
echo

cd ~/ffmpeg_sources 1>/dev/null
git clone --depth 1 http://git.videolan.org/git/x264 1>/dev/null
cd x264 1>/dev/null
PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static 1>/dev/null
make 1>/dev/null
make install 1>/dev/null

echo
echo #
echo Building x265
echo #
echo

cd ~/ffmpeg_sources 1>/dev/null
hg clone https://bitbucket.org/multicoreware/x265 1>/dev/null
cd ~/ffmpeg_sources/x265/build/linux 1>/dev/null
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source 1>/dev/null
make 1>/dev/null
make install 1>/dev/null

echo
echo #
echo Building fdk-aac
echo #
echo

cd ~/ffmpeg_sources 1>/dev/null
git clone --depth 1 https://github.com/mstorsjo/fdk-aac 1>/dev/null
cd fdk-aac 1>/dev/null
autoreconf -fiv 1>/dev/null
./configure --prefix="$HOME/ffmpeg_build" --disable-shared 1>/dev/null
make 1>/dev/null
make install 1>/dev/null

echo
echo #
echo Building lame
echo #
echo

cd ~/ffmpeg_sources 1>/dev/null
curl -L -O http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz 1>/dev/null
tar xzvf lame-3.99.5.tar.gz 1>/dev/null
cd lame-3.99.5 1>/dev/null
./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --disable-shared --enable-nasm 1>/dev/null
make 1>/dev/null
make install 1>/dev/null

echo
echo #
echo Building opus
echo #
echo

cd ~/ffmpeg_sources 1>/dev/null
curl -O https://archive.mozilla.org/pub/opus/opus-1.1.5.tar.gz 1>/dev/null
tar xzvf opus-1.1.5.tar.gz 1>/dev/null
cd opus-1.1.5 1>/dev/null
./configure --prefix="$HOME/ffmpeg_build" --disable-shared 1>/dev/null
make 1>/dev/null
make install 1>/dev/null

echo
echo #
echo Building libogg
echo #
echo

cd ~/ffmpeg_sources 1>/dev/null
curl -O https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.2.tar.gz 1>/dev/null
tar xzvf libogg-1.3.2.tar.gz 1>/dev/null
cd libogg-1.3.2 1>/dev/null
./configure --prefix="$HOME/ffmpeg_build" --disable-shared 1>/dev/null
make 1>/dev/null
make install 1>/dev/null

echo
echo #
echo Building libvorbis
echo #
echo

cd ~/ffmpeg_sources 1>/dev/null
curl -O https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.5.tar.gz 1>/dev/null
tar xzvf libvorbis-1.3.5.tar.gz 1>/dev/null
cd libvorbis-1.3.5 1>/dev/null
./configure --prefix="$HOME/ffmpeg_build" --with-ogg="$HOME/ffmpeg_build" --disable-shared 1>/dev/null
make 1>/dev/null
make install 1>/dev/null

echo
echo #
echo Building libvpx
echo #
echo

cd ~/ffmpeg_sources 1>/dev/null
git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git 1>/dev/null
cd libvpx 1>/dev/null
./configure --prefix="$HOME/ffmpeg_build" --disable-examples  --as=yasm 1>/dev/null
PATH="$HOME/bin:$PATH" make 1>/dev/null
make install 1>/dev/null

echo
echo #
echo Building ffmpeg
echo #
echo

cd ~/ffmpeg_sources 1>/dev/null
curl -O http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 1>/dev/null
tar xjvf ffmpeg-snapshot.tar.bz2 1>/dev/null
cd ffmpeg 1>/dev/null
PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib -ldl" --bindir="$HOME/bin" --pkg-config-flags="--static" --enable-gpl --enable-nonfree --enable-libfdk_aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 --with-openssl 1>/dev/null
make 1>/dev/null
make install 1>/dev/null
hash -r 1>/dev/null
