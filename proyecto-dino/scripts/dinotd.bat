@echo off
cls
echo ==============================
echo Compilando intRand.asm...
echo ==============================
tasm intRand.asm
tlink /t intRand.obj

echo.
echo Instalando INT 80h...
intRand.com

echo.
echo ==============================
echo Compilando archivos del juego...
echo ==============================
tasm /zi main.asm
::tasm /zi espera.asm
tasm /zi logic.asm
tasm /zi dino.asm
tasm /zi score.asm
tasm /zi sprite.asm
tasm /zi libsp.asm
::tasm /zi archivo.asm
tasm /zi menu.asm

echo.
echo ==============================
echo Vinculando...
echo ==============================
::tlink /v main.obj espera.obj logic.obj dino.obj score.obj sprite.obj libsp.obj archivo.obj menu.obj
tlink /v main.obj logic.obj dino.obj score.obj sprite.obj libsp.obj menu.obj

echo.
echo ==============================
echo Ejecutando el juego...
echo ==============================
td main
