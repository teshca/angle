echo off

:init

call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat"

:build

msbuild .\winrt\10\src\angle.sln /t:Rebuild /p:Configuration=Release /p:Platform=Win32 /m
msbuild .\winrt\10\src\angle.sln /t:Rebuild /p:Configuration=Release /p:Platform=x64 /m
msbuild .\winrt\10\src\angle.sln /t:Rebuild /p:Configuration=Release /p:Platform=ARM /m
msbuild .\winrt\10\src\angle.sln /t:Rebuild /p:Configuration=Debug /p:Platform=Win32 /m
msbuild .\winrt\10\src\angle.sln /t:Rebuild /p:Configuration=Debug /p:Platform=x64 /m
msbuild .\winrt\10\src\angle.sln /t:Rebuild /p:Configuration=Debug /p:Platform=ARM /m

:collect

rm -rf .\out
mkdir .\out

mkdir .\out\uwp.x86
mkdir .\out\uwp.x86\lib
cp .\winrt\10\src\Debug_Win32\lib\libEGL.lib .\out\uwp.x86\lib\contrib-angle-debug.lib
cp .\winrt\10\src\Release_Win32\lib\libEGL.lib .\out\uwp.x86\lib\contrib-angle.lib

mkdir .\out\uwp.x64
mkdir .\out\uwp.x64\lib
cp .\winrt\10\src\Debug_x64\lib\libEGL.lib .\out\uwp.x64\lib\contrib-angle-debug.lib
cp .\winrt\10\src\Release_x64\lib\libEGL.lib .\out\uwp.x64\lib\contrib-angle.lib

mkdir .\out\uwp.arm
mkdir .\out\uwp.arm\lib
cp .\winrt\10\src\Debug_ARM\lib\libEGL.lib .\out\uwp.arm\lib\contrib-angle-debug.lib
cp .\winrt\10\src\Release_ARM\lib\libEGL.lib .\out\uwp.arm\lib\contrib-angle.lib

mkdir .\out\include
cp -r .\include\EGL .\out\include\EGL
cp -r .\include\GLES2 .\out\include\GLES2
cp -r .\include\GLES3 .\out\include\GLES3
cp -r .\include\GLSLANG .\out\include\GLSLANG
cp -r .\include\KHR .\out\include\KHR
cp .\include\angle_gl.h .\out\include\angle_gl.h
cp .\include\angle_windowsstore.h .\out\include\angle_windowsstore.h

cp -r .\out\include .\out\uwp.x86\include
cp -r .\out\include .\out\uwp.x64\include
mv .\out\include .\out\uwp.arm\include

:success

echo DONE
exit 0
