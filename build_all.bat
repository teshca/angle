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

rmdir .\out /s /q

mkdir .\out\uwp.x86\lib || goto fail
copy .\winrt\10\src\Debug_Win32\lib\libEGL.lib .\out\uwp.x86\lib\contrib-angle-debug.lib || goto fail
copy .\winrt\10\src\Release_Win32\lib\libEGL.lib .\out\uwp.x86\lib\contrib-angle.lib || goto fail

mkdir .\out\uwp.x64\lib || goto fail
copy .\winrt\10\src\Debug_x64\lib\libEGL.lib .\out\uwp.x64\lib\contrib-angle-debug.lib || goto fail
copy .\winrt\10\src\Release_x64\lib\libEGL.lib .\out\uwp.x64\lib\contrib-angle.lib || goto fail

mkdir .\out\uwp.arm\lib || goto fail
copy .\winrt\10\src\Debug_ARM\lib\libEGL.lib .\out\uwp.arm\lib\contrib-angle-debug.lib || goto fail
copy .\winrt\10\src\Release_ARM\lib\libEGL.lib .\out\uwp.arm\lib\contrib-angle.lib || goto fail

mkdir .\out\include || goto fail
xcopy .\include\EGL .\out\include\EGL /I /E || goto fail
xcopy .\include\GLES2 .\out\include\GLES2 /I /E || goto fail
xcopy .\include\GLES3 .\out\include\GLES3 /I /E || goto fail
xcopy .\include\GLSLANG .\out\include\GLSLANG /I /E || goto fail
xcopy .\include\KHR .\out\include\KHR /I /E || goto fail
copy .\include\angle_gl.h .\out\include\angle_gl.h || goto fail
copy .\include\angle_windowsstore.h .\out\include\angle_windowsstore.h || goto fail

xcopy .\out\include .\out\uwp.x86\include /I /E || goto fail
xcopy .\out\include .\out\uwp.x64\include /I /E || goto fail
move .\out\include .\out\uwp.arm\include || goto fail

:success

echo DONE
exit 0

:fail

echo ERROR
exit /b