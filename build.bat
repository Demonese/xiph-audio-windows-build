@cd %~dp0
@cd
@set INSTALL_LOCATION=%cd%\install

:: "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"

@set NINJA_SYSTEM=-G Ninja -DCMAKE_C_COMPILER=cl -DCMAKE_CXX_COMPILER=cl
@set MSVC_SYSTEM=-G "Visual Studio 17 2022"
@set MSVC_ALL_TARGET=--target ALL_BUILD

@set COMMON_FLAGS=
@set COMMON_FLAGS=%COMMON_FLAGS% -DCMAKE_INSTALL_PREFIX=%INSTALL_LOCATION%
@set COMMON_FLAGS=%COMMON_FLAGS% -DCMAKE_BUILD_TYPE=Release
@set COMMON_FLAGS=%COMMON_FLAGS% -DBUILD_SHARED_LIBS=ON
@set COMMON_FLAGS=%COMMON_FLAGS% -DCMAKE_POLICY_DEFAULT_CMP0091=NEW
@set COMMON_FLAGS=%COMMON_FLAGS% -DCMAKE_MSVC_RUNTIME_LIBRARY="MultiThreaded$<$<CONFIG:Debug>:Debug>"

::@echo %COMMON_FLAGS%

@setlocal
    @echo ========== ogg ==========
    git clone https://github.com/xiph/ogg.git --recursive
    cd ogg
    cmake -S . -B build %MSVC_SYSTEM% %COMMON_FLAGS% -DBUILD_TESTING=OFF -DINSTALL_DOCS=OFF
    cmake --build build --config Release %MSVC_ALL_TARGET%
    cmake --install build --config Release
    @cd ..
@endlocal

@setlocal
    @echo ========== vorbis ==========
    git clone https://github.com/xiph/vorbis.git --recursive
    cd vorbis
    cmake -S . -B build %MSVC_SYSTEM% %COMMON_FLAGS% -DBUILD_TESTING=OFF -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    cmake --build build --config Release %MSVC_ALL_TARGET%
    cmake --install build --config Release
    @cd ..
@endlocal

@setlocal
    @echo ========== flac ==========
    git clone https://github.com/xiph/flac.git --recursive
    cd flac
    cmake -S . -B build %MSVC_SYSTEM% %COMMON_FLAGS% -DBUILD_CXXLIBS=OFF -DBUILD_TESTING=OFF -DBUILD_DOCS=OFF -DINSTALL_MANPAGES=OFF -DBUILD_PROGRAMS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_UTILS=OFF
    cmake --build build --config Release %MSVC_ALL_TARGET%
    cmake --install build --config Release
    cmake -E rm -rf D:\Project\mirrors\gitlab.xiph.org\xiph\install\include\FLAC++
    @cd ..
@endlocal

@setlocal
    @echo ========== opus ==========
    git clone https://github.com/xiph/opus.git --recursive
    cd opus
    cmake -S . -B build %MSVC_SYSTEM% %COMMON_FLAGS% -DOPUS_BUILD_SHARED_LIBRARY=ON -DOPUS_BUILD_TESTING=OFF -DOPUS_BUILD_PROGRAMS=OFF -DOPUS_STATIC_RUNTIME=ON
    cmake --build build --config Release %MSVC_ALL_TARGET%
    cmake --install build --config Release
    @cd ..
@endlocal

@setlocal
    @echo ========== opusfile ==========
    git clone https://github.com/xiph/opusfile.git --recursive
    cd opusfile
    cmake -S . -B build %MSVC_SYSTEM% %COMMON_FLAGS% -DOP_DISABLE_HTTP=ON -DOP_DISABLE_EXAMPLES=ON -DOP_DISABLE_DOCS=ON
    cmake --build build --config Release %MSVC_ALL_TARGET%
    cmake --install build --config Release
    @cd ..
@endlocal
