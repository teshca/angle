:init

call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat" || goto fail

:build

msbuild .\winrt\10\src\angle.sln /t:Rebuild /p:Configuration=Release /p:Platform=Win32 /m || goto fail
msbuild .\winrt\10\src\angle.sln /t:Rebuild /p:Configuration=Release /p:Platform=x64 /m || goto fail
msbuild .\winrt\10\src\angle.sln /t:Rebuild /p:Configuration=Release /p:Platform=ARM /m || goto fail
msbuild .\winrt\10\src\angle.sln /t:Rebuild /p:Configuration=Debug /p:Platform=Win32 /m || goto fail
msbuild .\winrt\10\src\angle.sln /t:Rebuild /p:Configuration=Debug /p:Platform=x64 /m || goto fail
msbuild .\winrt\10\src\angle.sln /t:Rebuild /p:Configuration=Debug /p:Platform=ARM /m || goto fail

:collect

rm -rf .\out
mkdir .\out || goto fail

mkdir .\out\uwp.x86 || goto fail
mkdir .\out\uwp.x86\lib || goto fail
cp .\winrt\10\src\Debug_Win32\lib\libEGL.lib .\out\uwp.x86\lib\contrib-angle-debug.lib || goto fail
cp .\winrt\10\src\Release_Win32\lib\libEGL.lib .\out\uwp.x86\lib\contrib-angle.lib || goto fail

mkdir .\out\uwp.x64 || goto fail
mkdir .\out\uwp.x64\lib || goto fail
cp .\winrt\10\src\Debug_x64\lib\libEGL.lib .\out\uwp.x64\lib\contrib-angle-debug.lib || goto fail
cp .\winrt\10\src\Release_x64\lib\libEGL.lib .\out\uwp.x64\lib\contrib-angle.lib || goto fail

mkdir .\out\uwp.arm || goto fail
mkdir .\out\uwp.arm\lib || goto fail
cp .\winrt\10\src\Debug_ARM\lib\libEGL.lib .\out\uwp.arm\lib\contrib-angle-debug.lib || goto fail
cp .\winrt\10\src\Release_ARM\lib\libEGL.lib .\out\uwp.arm\lib\contrib-angle.lib || goto fail

mkdir .\out\include || goto fail
cp -r .\include\EGL .\out\include\EGL || goto fail
cp -r .\include\GLES2 .\out\include\GLES2 || goto fail
cp -r .\include\GLES3 .\out\include\GLES3 || goto fail
cp -r .\include\GLSLANG .\out\include\GLSLANG || goto fail
cp -r .\include\KHR .\out\include\KHR || goto fail
cp .\include\angle_gl.h .\out\include\angle_gl.h || goto fail
cp .\include\angle_windowsstore.h .\out\include\angle_windowsstore.h || goto fail

cp -r .\out\include .\out\uwp.x86\include || goto fail
cp -r .\out\include .\out\uwp.x64\include || goto fail
mv .\out\include .\out\uwp.arm\include || goto fail

:success

echo DONE
exit 0

:fail

echo ERROR
exit /b