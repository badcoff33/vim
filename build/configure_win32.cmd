@echo off
:: Taken from http://blog.mgiuffrida.com/2015/06/27/building-vim-on-windows.html

echo "Configuring VS version and architecture ..."

:: Windows SDK Include directory. No quotation marks.
::set SDK_INCLUDE_DIR=C:\Program Files (x86)\Windows Kits\10\Include

:: Visual Studio directory. Quotation marks.
set VS_DIR="C:\Program Files (x86)\Microsoft Visual Studio 14.0"

:: Target architecture, AMD64 (64-bit) or I386 (32-bit)
set CPU=AMD64

:: Toolchain, x86_amd64 (cross-compile 64-bit) or x86 (32-bit) or amd64 (64-bit)
set TOOLCHAIN=x86_amd64

echo "Configuring Vim vaiables ..."

:: TINY, SMALL, NORMAL, BIG or HUGE. NORMAL or above recommended
set FEATURES=BIG

:: yes for gvim, no for vim
set GUI=yes

:: Whatever IDE integrations we don't need
set NETBEANS=no

:: UTF-8 encoding
set MBYTE=yes

:: Enable Python scripting
set DYNAMIC_PYTHON=yes
set PYTHON=p:
set PYTHON_VER=27

:: Visual Studio is kind of silly—it will repeatedly add stuff to your PATH
:: until it becomes too long to work. Run the VS batch only the first time or
:: when TOOLCHAIN changed. 
if "%TOOLCHAIN%" neq "%SAVEDTOOLCHAIN%" (
    echo "Configuring Visual Studio..."
    call %VS_DIR%\VC\vcvarsall.bat %TOOLCHAIN%
)
set SAVEDTOOLCHAIN=%TOOLCHAIN%
