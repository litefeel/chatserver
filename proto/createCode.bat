::设置当前目录为%cd%
@echo off
PUSHD %~dp0
cd ..
set AS3_OUT=%CD%/client/src
set JAVA_OUT=%CD%/server/src
::还原当前目录为pushd设置之前的目录
popd

set IMPORT_PATH=%cd%
@echo on
protoc.exe ^
    --proto_path="%IMPORT_PATH%" ^
    --plugin=protoc-gen-as3="%cd%/protoc-gen-as3.bat" ^
    --as3_out="%AS3_OUT%" ^
    --java_out="%JAVA_OUT%" ^
    "%IMPORT_PATH%/request.proto" ^
    "%IMPORT_PATH%/responder.proto"
pause
