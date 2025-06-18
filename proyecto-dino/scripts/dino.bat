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
tasm main.asm
::tasm espera.asm
tasm logic.asm
tasm dino.asm
tasm score.asm
tasm sprite.asm
tasm libsp.asm
::tasm archivo.asm
tasm menu.asm
tasm score.asm

echo.
echo ==============================
echo Vinculando...
echo ==============================
::tlink main.obj espera.obj logic.obj dino.obj score.obj sprite.obj libsp.obj archivo.obj menu.obj
tlink main.obj logic.obj dino.obj score.obj sprite.obj libsp.obj menu.obj

echo.
echo ==============================
echo Ejecutando el juego...
echo ==============================
main.exe
