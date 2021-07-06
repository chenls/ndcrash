clear
dir=$(cd $(dirname $0) && pwd)
cd $dir

echo $ANDROID_NDK
rm -rf out/build-android-aarch64
mkdir -p out/build-android-aarch64
cd out/build-android-aarch64
cmake -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK/build/cmake/android.toolchain.cmake" \
    ../.. \
    -DCMAKE_BUILD_TYPE=Debug \
    -DANDROID_ABI="arm64-v8a" \
    -DANDROID_PLATFORM=android-21 \
    -DANDROID_STL=c++_static \
    -DENABLE_CXXABI:BOOL=ON \
    -DENABLE_INPROCESS:BOOL=ON \
    -DEENABLE_OUTOFPROCESS_ALL_THREADS:BOOL=ON

# print verbose info
# make VERBOSE=1
make -j32
if [ $? -ne 0 ]; then
    exit -1
fi
cd - &>/dev/null

rm -rf out/build-android-armv7
mkdir -p out/build-android-armv7
cd out/build-android-armv7
cmake -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK/build/cmake/android.toolchain.cmake" \
    ../.. \
    -DCMAKE_BUILD_TYPE=Debug \
    -DANDROID_ABI="armeabi-v7a" \
    -DANDROID_PLATFORM=android-21 \
    -DANDROID_STL=c++_static \
    -DENABLE_CXXABI:BOOL=ON \
    -DENABLE_INPROCESS:BOOL=ON \
    -DEENABLE_OUTOFPROCESS_ALL_THREADS:BOOL=ON

# print verbose info
# make VERBOSE=1
make -j32
if [ $? -ne 0 ]; then
    exit -1
fi
cd - &>/dev/null
