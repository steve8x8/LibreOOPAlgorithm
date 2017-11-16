

rem Download apk file
rem ==============
mkdir LibreLink
if exist LibreLink\LibreLink_v1.3.2.4_apkpure.com.apk goto :apk_exists

tools\windows\wget -O LibreLink\LibreLink_v1.3.2.4_apkpure.com.apk --no-check-certificate "https://download.apkpure.com/b/apk/Y29tLmxpYnJlbGluay5hcHBfMTA2NTdfNzlkZGIyZDc?_fn=TGlicmVMaW5rX3YxLjMuMi40X2Fwa3B1cmUuY29tLmFwaw%3D%3D&k=322c052d0f9c34b28c1f67bc88de53c15a0fe122&as=2f14426570424edf58d775b630faf2645a0d3e9a&_p=Y29tLmxpYnJlbGluay5hcHA%3D&c=1%7CMEDICAL"

mkdir LibreLink\apk
7z -oLibreLink\apk x LibreLink\LibreLink_v1.3.2.4_apkpure.com.apk


:apk_exists

rem Copy the commited apk, and manipulate it
rem ==========================
rmdir /Q /s temp
mkdir temp

copy apk\app-debug.apk temp

rmdir /Q /s temp\dir
md temp\dir

7z x -otemp\dir temp\app-debug.apk
rmdir /Q /s temp\dir\META-INF

copy LibreLink\apk\lib\arm64-v8a\libDataProcessing.so temp\dir\lib\arm64-v8a\libDataProcessing.so
copy LibreLink\apk\lib\armeabi\libDataProcessing.so temp\dir\lib\armeabi\libDataProcessing.so
copy LibreLink\apk\lib\armeabi-v7a\libDataProcessing.so temp\dir\lib\armeabi-v7a\libDataProcessing.so
copy LibreLink\apk\lib\x86\libDataProcessing.so temp\dir\lib\x86\libDataProcessing.so
copy LibreLink\apk\lib\x86_64\libDataProcessing.so temp\dir\lib\x86_64\libDataProcessing.so



copy LibreLink\LibreLink_v1.3.2.4_apkpure.com.apk temp\dir\res\raw\original_apk

cd temp\dir
7z -tzip a apk.aunaligned.zip
cd ..\..
move temp\dir\apk.aunaligned.zip temp

"C:\Program Files\Android\Android Studio\jre\bin\jarsigner.exe"  -verbose -sigalg MD5withRSA -digestalg SHA1 -keystore tools\windows\debug.keystore  -storepass android  temp\apk.aunaligned.zip androiddebugkey
move temp\apk.aunaligned.zip apk.aunaligned.apk
